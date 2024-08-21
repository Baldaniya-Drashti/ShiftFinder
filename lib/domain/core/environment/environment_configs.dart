import 'package:shift/domain/core/environment/base_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DevConfig implements BaseConfig {
  @override
  String get apiHost => dotenv.get("DEV_API_BASE_URL");

  @override
  String get socketHost => dotenv.get("DEV_SOCKET_URL");

  @override
  bool get reportErrors => false;
  @override
  bool get trackEvents => false;
  @override
  bool get useHttpsScheme => false;

  @override
  bool get isDev => true;
  @override
  bool get isStaging => false;
  @override
  bool get isProd => false;
}

class StagingConfig implements BaseConfig {
  @override
  String get apiHost => dotenv.get("STAGING_API_BASE_URL");

  @override
  String get socketHost => dotenv.get("STAGING_SOCKET_URL");

  @override
  bool get reportErrors => true;
  @override
  bool get trackEvents => false;
  @override
  bool get useHttpsScheme => true;

  @override
  bool get isDev => false;
  @override
  bool get isStaging => true;
  @override
  bool get isProd => false;
}

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => dotenv.get("PROD_API_BASE_URL");

  @override
  String get socketHost => dotenv.get("PROD_SOCKET_URL");
  @override
  bool get reportErrors => true;
  @override
  bool get trackEvents => true;
  @override
  bool get useHttpsScheme => true;

  @override
  bool get isDev => false;
  @override
  bool get isStaging => false;
  @override
  bool get isProd => true;
}
