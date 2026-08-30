import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:deposit_calc_satelit/core/di/service_locator.config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
@InjectableInit(preferRelativeImports: false)
Future<void> initServiceLocator() async {
  await getIt.init();
}

@module
abstract class SharedPreferencesModule {
  @singleton
  @preResolve
  Future<SharedPreferences> get sp => SharedPreferences.getInstance();
}

@module
abstract class DioModule {
  @lazySingleton
  Dio dio() => Dio();
}

@module
abstract class LoggerModule {
  @singleton
  Logger logger() => Logger();
}
