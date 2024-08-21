import 'dart:convert';
import 'dart:io';

import 'package:shift/domain/core/api_constants.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/network/interceptor/api_error_interceptors.dart';
import 'package:shift/infrastructure/core/network/interceptor/dio_connectivity_request_retrier.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'dart:developer' as developer;

@lazySingleton
class ApiService {
  CommonResponse commonResponse = CommonResponse();
  static Dio dio = Dio();

  static Dio initAPIService({bool isMultipart = false}) {
    final interceptor = InterceptorsWrapper(
      onRequest: (options, handler) {
        String? userToken = getUserToken();
        options.headers.addAll({
          "Authorization": "Bearer $userToken",
        });

        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        return handler.resolve(response); // continue
      },
      onError: (DioException e, handler) async {
        return handler.next(e); //continue
      },
    );
    var acceptHeader = Headers.jsonContentType;
    var contentTypeHeader = isMultipart
        ? Headers.multipartFormDataContentType
        : Headers.jsonContentType;
    var headers = {
      HttpHeaders.acceptHeader: acceptHeader,
      HttpHeaders.contentTypeHeader: contentTypeHeader,
    };
    final BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      //5s
      receiveTimeout: const Duration(milliseconds: 15000),
      //15s
      headers: headers,
      contentType: isMultipart
          ? Headers.multipartFormDataContentType
          : Headers.jsonContentType,
    );

    dio = Dio(options)
      ..interceptors.addAll([
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
        // LoggingInterceptor(),
        AppInterceptors(
            requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        )),
        interceptor,
      ]);

    return dio;
  }

  Future<CommonResponse> postMethod(String path, dynamic data,
      {bool isMultipart = false,
      FormData? formData,
      Map<String, dynamic>? queryParameters}) async {
    dio = initAPIService(isMultipart: isMultipart);

    var response = await dio.post(
      path,
      data: isMultipart ? formData : data,
      queryParameters: queryParameters,
    );

    return CommonResponse.fromJson(response.data);
  }

  Future<CommonResponse?> getMethod(String path,
      {Map<String, dynamic>? queryParameters}) async {
    dio = initAPIService();

    var response = await dio.get(
      path,
      queryParameters: queryParameters,
    );

    return CommonResponse.fromJson(response.data);
  }

  Future<CommonResponse?> putMethod(String path,
      {Map<String, dynamic>? queryParameters,
      dynamic data,
      bool isMultipart = false,
      FormData? formData}) async {
    dio = initAPIService(isMultipart: isMultipart);

    var response = await dio.put(
      path,
      data: isMultipart ? formData : data,
      queryParameters: queryParameters,
    );

    return CommonResponse.fromJson(response.data);
  }

  Future<CommonResponse?> deleteMethod(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    dio = initAPIService();

    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return CommonResponse.fromJson(response.data);
  }
}

const _titleSeparator = '══════════════════════════════════════════════════';
const _encoder = JsonEncoder.withIndent('  ');

mixin _LogMixin {
  void printRequest(Object? value, [String prefix = '']) =>
      _print(value, prefix);

  void printError(Object? value, [String prefix = '']) => _print(value, prefix);

  void printResponse(Object? value, [String prefix = '']) =>
      _print(value, prefix);

  void _print(Object? object, String prefix) {
    String content;
    if (object is Map || object is List) {
      content = _encoder.convert(object);
    } else {
      content = object.toString();
    }
    if (prefix.isNotEmpty) content = '$prefix: $content';
    developer.log(content);
  }
}

class LoggingInterceptor extends InterceptorsWrapper with _LogMixin {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printRequest('$_titleSeparator Request Options $_titleSeparator');
    printRequest('[${options.method.toUpperCase()}] ${options.uri}');
    if (options.queryParameters.isNotEmpty) {
      printRequest(options.queryParameters, 'QueryParameters');
    }
    printRequest(options.headers, 'Headers');
    if (options.data is Map || options.data is Iterable) {
      printRequest(options.data, 'Data');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printResponse('$_titleSeparator Response $_titleSeparator');
    printResponse(
      '[${response.requestOptions.method.toUpperCase()}] [${response.statusCode}] ${response.requestOptions.uri}',
    );
    if (response.data is Map || response.data is List) {
      printResponse(response.data, 'Data');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    printError('$_titleSeparator DioError $_titleSeparator');
    printError(
        '[${err.requestOptions.method.toUpperCase()}] [${err.response?.statusCode}] ${err.requestOptions.uri}');
    printError('[${err.type}] ${err.message}');
    if (err.response?.data is Map) printError(err.response?.data, 'Data');
    super.onError(err, handler);
  }
}
