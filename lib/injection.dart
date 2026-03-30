import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/core/environment/base_config.dart';
import 'package:shift/domain/core/environment/environment.dart';
import 'package:shift/domain/core/environment/environment_configs.dart';
import 'package:shift/injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void configureInjection(String env) {
  getIt.init(environment: env);

  if (env == EnvironmentCongig.dev) {
    getIt.registerSingleton<BaseConfig>(DevConfig());
  } else if (env == EnvironmentCongig.staging) {
    getIt.registerSingleton<BaseConfig>(StagingConfig());
  } else if (env == EnvironmentCongig.prod) {
    getIt.registerSingleton<BaseConfig>(ProdConfig());
  }
}
