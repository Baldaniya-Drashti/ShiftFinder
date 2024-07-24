// @LazySingleton(as: IMainFacade)
// class MainFacade implements IMainFacade {
//   final ApiService apiService;
//   static const int _perPage = 25;

//   MainFacade({required this.apiService});

//   @override
//   Future<Either<MainFailure, CommonResponse>> getProductListAPI({
//     required int page,
//     String? productId,
//   }) async {
//     try {
//       Map<String, dynamic> mapData = {
//         'page': page,
//         'limit': _perPage,
//       };
//       if (productId != null) {
//         mapData.addAll({
//           'is_like_list': "1",
//           'product_id': productId,
//         });
//       }
//       final res = await apiService.getMethod(ApiConstants.getCustomerProducts,
//           queryParameters: mapData);

//       if (res != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CommonResponse>> getProductDetailsAPI({
//     required String productId,
//     required int page,
//   }) async {
//     try {
//       final res = await apiService.getMethod(
//           '${ApiConstants.getCustomerProductsDetails}/$productId',
//           queryParameters: {
//             'page': page,
//             'limit': _perPage,
//           });

//       if (res != null && res.data != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CommonResponse>> searchProductListAPI({
//     required int page,
//     String searchText = '',
//     required List<MapEntry<String, dynamic>> selectedFilterList,
//   }) async {
//     try {
//       var mapData = <String, dynamic>{
//         'page': page,
//         'limit': _perPage,
//       };

//       if (selectedFilterList.isNotEmpty) {
//         mapData.addEntries(selectedFilterList);
//       }
//       if (searchText.isNotEmpty) {
//         mapData.addAll({'product': searchText.trim()});
//       }
//       final res = await apiService.getMethod(ApiConstants.searchProduct,
//           queryParameters: mapData);

//       if (res != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CartAddDTO>> addProductToCart(
//       {required String productId}) async {
//     try {
//       final res = await apiService
//           .postMethod(ApiConstants.addProductToCart, {"product_id": productId});

//       if (res.data != null) {
//         return right(CartAddDTO.fromJson(res.data));
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> deleteProductFromCart(
//       {required String productId}) async {
//     try {
//       final res = await apiService
//           .deleteMethod('${ApiConstants.removeProductFromCart}/$productId');

//       if (res != null && res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CommonResponse>> getCartListAPI(
//       {required int page}) async {
//     try {
//       var mapData = <String, dynamic>{
//         'page': page,
//         'limit': _perPage,
//       };

//       final res = await apiService.getMethod(ApiConstants.getCartList,
//           queryParameters: mapData);

//       if (res != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> addProductToFavourite(
//       {required String productId}) async {
//     try {
//       final res = await apiService.postMethod(ApiConstants.addFavourite, {
//         'product_id': productId,
//       });

//       if (res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CommonResponse>> getFavouriteAPI(
//       {required int page}) async {
//     try {
//       var mapData = <String, dynamic>{
//         'page': page,
//         'limit': _perPage,
//       };

//       final res = await apiService.getMethod(ApiConstants.getFavouriteList,
//           queryParameters: mapData);

//       if (res != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> addShippingAddress(
//       {required Username fullName,
//       required MobileNumber mobileNumber,
//       required String countryCode,
//       required InputEmptyOrNot address,
//       required InputEmptyOrNot landMark,
//       required InputEmptyOrNot state,
//       required InputEmptyOrNot city,
//       required PinCode pinCode}) async {
//     try {
//       final res = await apiService.postMethod(
//         ApiConstants.addShippingAddress,
//         {
//           "full_name": fullName.getOrCrash(),
//           "country_code": countryCode,
//           "mobile": mobileNumber.getOrCrash(),
//           "address": address.getOrCrash(),
//           "landmark": landMark.getOrCrash(),
//           "state": state.getOrCrash(),
//           "city": city.getOrCrash(),
//           "pincode": pinCode.getOrCrash(),
//         },
//       );

//       if (res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, List<ShippingAddressDTO>>>
//       getShippingAddressAPI() async {
//     try {
//       final res = await apiService.getMethod(
//         ApiConstants.getShippingAddressList,
//       );

//       if (res != null && res.data != null) {
//         var list = res.data as List<dynamic>;
//         return right(list.map((e) => ShippingAddressDTO.fromJson(e)).toList());
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> editShippingAddress(
//       {required String id,
//       required Username fullName,
//       required MobileNumber mobileNumber,
//       required String countryCode,
//       required InputEmptyOrNot address,
//       required InputEmptyOrNot landMark,
//       required InputEmptyOrNot state,
//       required InputEmptyOrNot city,
//       required PinCode pinCode}) async {
//     try {
//       final res = await apiService.postMethod(
//         ApiConstants.updateShippingAddress,
//         {
//           "id": id,
//           "full_name": fullName.getOrCrash(),
//           "country_code": countryCode,
//           "mobile": mobileNumber.getOrCrash(),
//           "address": address.getOrCrash(),
//           "landmark": landMark.getOrCrash(),
//           "state": state.getOrCrash(),
//           "city": city.getOrCrash(),
//           "pincode": pinCode.getOrCrash(),
//         },
//       );

//       if (res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> deleteShippinAddress(
//       {required String id}) async {
//     try {
//       final res = await apiService.deleteMethod(
//         '${ApiConstants.deleteShippingAddress}/$id',
//       );

//       if (res != null && res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> addPaymentMethod({
//     required String paymentMethodId,
//     bool isDefault = false,
//   }) async {
//     try {
//       var mapData = {
//         "payment_method_id": paymentMethodId,
//       };
//       if (isDefault) {
//         mapData.addAll({"is_default": "1"});
//       }
//       // log(cardDate.getOrCrash()?.split('/')[0] ?? "");
//       final res = await apiService.postMethod(
//         ApiConstants.addPaymentMethod,
//         mapData,
//       );

//       if (res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, List<GetCardsDTO>>> getPaymentMethod() async {
//     try {
//       final res = await apiService.getMethod(
//         ApiConstants.getPaymentMethod,
//       );

//       if (res != null && res.data != null) {
//         var list = res.data as List<dynamic>;
//         return right(list.map((e) => GetCardsDTO.fromJson(e)).toList());
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> deleteProductFromFavourite(
//       {required String productId}) async {
//     try {
//       final res = await apiService
//           .deleteMethod('${ApiConstants.removeFavourite}/$productId');

//       if (res != null && res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> addContactSupport(
//       {required InputEmptyOrNot title,
//       required InputEmptyOrNot message}) async {
//     try {
//       // log(cardDate.getOrCrash()?.split('/')[0] ?? "");
//       final res = await apiService.postMethod(
//         ApiConstants.contactSupport,
//         {
//           "title": title.getOrCrash(),
//           "description": title.getOrCrash(),
//         },
//       );

//       if (res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> deleteCard({required String id}) async {
//     try {
//       final res = await apiService.deleteMethod(
//         '${ApiConstants.deletePaymentMethod}/$id',
//       );

//       if (res != null && res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> makeCardDefault(
//       {required String id}) async {
//     try {
//       // log(cardDate.getOrCrash()?.split('/')[0] ?? "");
//       final res = await apiService.postMethod(
//         ApiConstants.makeDefaultPaymentMethod,
//         {"payment_method_id": id},
//       );

//       if (res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CommonResponse>> orderCheckoutAPI(
//       {String? productId,
//       String? quantity,
//       bool isFromcart = false,
//       required int page}) async {
//     try {
//       Map<String, dynamic> mapData = {
//         'page': page,
//         'limit': _perPage,
//       };
//       if (isFromcart) {
//         mapData.addAll({'is_cart': "1"});
//       } else {
//         mapData.addAll({
//           'product_id': productId,
//           'quantity': quantity,
//         });
//       }
//       final res = await apiService.getMethod(ApiConstants.orderCheckout,
//           queryParameters: mapData);

//       if (res != null && res.data != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> orderPlacetAPI(
//       {required CheckoutDTO checkoutDTO}) async {
//     try {
//       var productList = <Map<String, dynamic>>[];
//       for (var i = 0; i < (checkoutDTO.products?.length ?? 0); i++) {
//         productList.add({
//           "product_id": checkoutDTO.products?[i].id.toString() ?? "",
//           "quantity": checkoutDTO.products?[i].quantity.toString() ?? "",
//           "amount": ((checkoutDTO.products?[i].price ?? 0) *
//                   (checkoutDTO.products?[i].quantity ?? 1))
//               .toString()
//         });
//       }
//       Map<String, dynamic> mapData = {
//         "product": productList,
//         "shipping_address_id":
//             checkoutDTO.shipping_address?.id.toString() ?? "",
//         "shipping_charge": checkoutDTO.shipping_charge?.toString() ?? "",
//         "tax": checkoutDTO.tax?.toString() ?? "",
//       };
//       final res = await apiService.postMethod(
//         ApiConstants.orderPlace,
//         mapData,
//       );

//       if (res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CommonResponse>> getMyOrdersAPI(
//       {required int page}) async {
//     try {
//       var mapData = <String, dynamic>{
//         'page': page,
//         'limit': _perPage,
//       };

//       final res = await apiService.getMethod(ApiConstants.getMyOrder,
//           queryParameters: mapData);

//       if (res != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CommonResponse>> getShopDetailAPI(
//       {required int page, required String shopID}) async {
//     try {
//       var mapData = <String, dynamic>{
//         'page': page,
//         'limit': _perPage,
//         'shop_id': shopID,
//       };

//       final res = await apiService.getMethod(ApiConstants.getVenderDetail,
//           queryParameters: mapData);

//       if (res != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CommonResponse>> getShopDetailFilterAPI({
//     required int page,
//     required String shopID,
//     required List<MapEntry<String, dynamic>> selectedFilterList,
//   }) async {
//     try {
//       var mapData = <String, dynamic>{
//         'page': page,
//         'limit': _perPage,
//       };

//       if (selectedFilterList.isNotEmpty) {
//         for (var i = 0; i < selectedFilterList.length; i++) {
//           if (selectedFilterList[i].key.contains('New')) {
//             mapData.addAll({'is_new': '1'});
//           }
//           if (selectedFilterList[i].key.contains('Top Selling')) {
//             mapData.addAll({'top_selling': '1'});
//           }

//           if (selectedFilterList[i].key.contains('Price \u{2191}')) {
//             mapData.addAll({'price': '0'});
//           }

//           if (selectedFilterList[i].key.contains('Price \u{2193}')) {
//             mapData.addAll({'price': '1'});
//           }
//           if (selectedFilterList[i].key.contains('Categories')) {
//             mapData.addAll({'category[]': selectedFilterList[i].value});
//           }
//         }
//         // mapData.addEntries(selectedFilterList);
//       }

//       final res = await apiService.getMethod(
//           '${ApiConstants.getVenderDetailFilter}/$shopID',
//           queryParameters: mapData);

//       if (res != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, OrderDetailDTO>> getOrderDetailAPI(
//       {required String orderId}) async {
//     try {
//       final res = await apiService.getMethod(
//         '${ApiConstants.getMyOrder}/$orderId',
//       );

//       if (res != null && res.data != null) {
//         return right(OrderDetailDTO.fromJson(res.data));
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> cancelOrderAPI(
//       {required String id}) async {
//     try {
//       final res = await apiService.deleteMethod(
//         '${ApiConstants.cancelOrder}/$id',
//       );

//       if (res != null && res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, List<ReturnReasonModel>>>
//       geReasonRefundList() async {
//     try {
//       final res = await apiService.getMethod(
//         ApiConstants.returnReasonList,
//       );

//       if (res != null && res.data != null) {
//         var list = res.data as List<dynamic>;
//         return right(list.map((e) => ReturnReasonModel.fromJson(e)).toList());
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> returnRequestAPI(
//       {required String orderId,
//       required String reasonId,
//       required List<String> imageList,
//       String? comment}) async {
//     try {
//       List<MultipartFile> photoMultipartFileList = [];

//       for (int i = 0; i < imageList.length; i++) {
//         if (imageList[i].isNotEmpty) {
//           var photoMultipartFile = await MultipartFile.fromFile(
//             imageList[i],
//             filename: imageList[i],
//             //contentType: MediaType('image', 'png'),
//           );
//           photoMultipartFileList.add(photoMultipartFile);
//         }
//       }

//       //   formData.files.add(MapEntry(key, value));

//       var formData = FormData.fromMap(<String, dynamic>{
//         'order_id': orderId,
//         'reason_id': reasonId,
//         "images[]": photoMultipartFileList,
//         'comment': comment,
//       });
//       final res = await apiService.postMethod(ApiConstants.returnRequest, {},
//           isMultipart: true, formData: formData);

//       if (res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CommonResponse>> getChatListAPI(
//       {required int page}) async {
//     try {
//       var mapData = <String, dynamic>{
//         'page': page,
//         'limit': _perPage,
//       };

//       final res = await apiService.getMethod(ApiConstants.getChatList,
//           queryParameters: mapData);

//       if (res != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CommonResponse>> getChatDetailListAPI(
//       {required int page, required String recieverId}) async {
//     try {
//       var mapData = <String, dynamic>{
//         'page': page,
//         'limit': _perPage,
//         'receiver_id': recieverId,
//       };

//       final res = await apiService.getMethod(ApiConstants.getChatDetailList,
//           queryParameters: mapData);

//       if (res != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CommonResponse>> getNotificationListAPI(
//       {required int page}) async {
//     try {
//       var mapData = <String, dynamic>{
//         'page': page,
//         'limit': _perPage,
//       };

//       final res = await apiService.getMethod(ApiConstants.getNotificationList,
//           queryParameters: mapData);

//       if (res != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> getReadNotificationAPI({
//     required String notificationId,
//   }) async {
//     try {
//       final res = await apiService.getMethod(
//         '${ApiConstants.readNotification}/$notificationId',
//       );

//       if (res?.dioMessage != null) {
//         return right(res?.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, GetReviewProductDTO>> reviewNotificationAPI({
//     required String dataId,
//   }) async {
//     try {
//       final res = await apiService.getMethod(
//         '${ApiConstants.getReviewProduct}/$dataId',
//       );

//       if (res?.data != null) {
//         return right(GetReviewProductDTO.fromJson(res?.data));
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, CommonResponse>> getProductReviewAPI(
//       {required String productId, required int page}) async {
//     try {
//       final res =
//           await apiService.getMethod(ApiConstants.getReviews, queryParameters: {
//         'page': page,
//         'limit': _perPage,
//         'product': productId,
//       });

//       if (res != null && res.data != null) {
//         return right(res);
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }

//   @override
//   Future<Either<MainFailure, String>> giveReviewToProduct(
//       {required String productId,
//       required String rating,
//       required String reviewComment}) async {
//     try {
//       var mapData = {
//         "product_id": productId,
//         "rate": rating,
//         "review": reviewComment
//       };
//       final res =
//           await apiService.postMethod(ApiConstants.giveReviews, mapData);

//       if (res.dioMessage != null) {
//         return right(res.dioMessage ?? "");
//       } else {
//         return left(const MainFailure.serverError());
//       }
//     } on DioException catch (err) {
//       if (err.response != null) {
//         var commonRespose = CommonResponse.fromJson(err.response?.data);

//         if (commonRespose.dioMessage != null) {
//           return left(
//               MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
//         }
//       } else if (err.type == DioExceptionType.connectionError) {
//         return left(const MainFailure.networkError());
//       }

//       return left(const MainFailure.serverError());
//     }
//   }
// }
