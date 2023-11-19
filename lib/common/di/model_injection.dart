import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/news_repository_impl.dart';
import '../../data/service/remote/news_remote.dart';
import 'app_dependency_injection.dart';

/// Data model injection
class ModelInjection {
  static void inject() {
    injector.pushNewScope(
      scopeName: 'In App Purchase Model',
      init: (GetIt getIt) {
        getIt.registerLazySingleton<NewsRemote>(() => NewsRemote(dio: getIt.get<Dio>()));
        getIt.registerLazySingleton<NewsRepositoryImpl>(
            () => NewsRepositoryImpl(service: getIt.get<NewsRemote>()));
      },
    );
  }
}
