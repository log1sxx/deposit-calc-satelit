// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:deposit_calc_satelit/core/di/service_locator.dart' as _i658;
import 'package:deposit_calc_satelit/core/network/api_client.dart' as _i118;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final loggerModule = _$LoggerModule();
    final dioModule = _$DioModule();
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.sp,
      preResolve: true,
    );
    gh.singleton<_i974.Logger>(() => loggerModule.logger());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio());
    gh.factory<_i118.ApiClient>(() => _i118.ApiClient(gh<_i361.Dio>()));
    return this;
  }
}

class _$SharedPreferencesModule extends _i658.SharedPreferencesModule {}

class _$LoggerModule extends _i658.LoggerModule {}

class _$DioModule extends _i658.DioModule {}
