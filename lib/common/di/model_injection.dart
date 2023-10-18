import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/news_repository_impl.dart';
import '../../data/service/news_service.dart';
import 'app_dependency_injection.dart';

/// Data model injection
class ModelInjection {
  static void inject() {
    injector.pushNewScope(
      scopeName: 'In App Purchase Model',
      init: (GetIt getIt) {
        getIt.registerLazySingleton<NewsService>(() => NewsService(dio: getIt.get<Dio>()));
        getIt.registerLazySingleton<NewsRepositoryImpl>(
            () => NewsRepositoryImpl(service: getIt.get<NewsService>()));
      },
    );
  }
}
