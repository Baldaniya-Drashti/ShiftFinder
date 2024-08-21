import 'package:shift/domain/core/environment/environment_configs.dart';

abstract class BaseConfig {
  String get apiHost;
  String get socketHost;
  bool get useHttpsScheme;
  bool get trackEvents;
  bool get reportErrors;

  bool get isProd => this is ProdConfig;
  bool get isDev => this is DevConfig;
  bool get isStaging => this is StagingConfig;
}
