import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../app_setting.dart';
import '../base/app_interceptor.dart';
import '../config/config.dart';
import 'app_dependency_injection.dart';

class AppSettingInjection {
  static void inject() {
    BaseOptions options = BaseOptions(baseUrl: Config.apiService, headers: {
      "Authorization": Config.apiKey,
    });

    injector.pushNewScope(
        scopeName: 'App Setting',
        init: (GetIt getIt) {
          getIt.registerLazySingleton<AppSetting>(() => AppSetting());
          getIt.registerLazySingleton<Dio>(
            () => Dio(options)
              ..interceptors.add(AppInterceptor())
              ..interceptors.add(LogInterceptor(responseBody: true)),
          );
        });
  }
}
