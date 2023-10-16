import 'package:get_it/get_it.dart';

import '../../data/repository/news_repository_impl.dart';
import '../../domain/usecase/news/get_news_usecase.dart';
import 'app_dependency_injection.dart';

/// Domain Layer Injection
class DomainInjection {
  static void inject() {
    injector.pushNewScope(
        scopeName: 'News Domain',
        init: (GetIt getIt) {
          getIt.registerLazySingleton<GetNewsUseCase>(
            () => GetNewsUseCase(
              repository: getIt.get<NewsRepositoryImpl>(),
            ),
          );
        });
  }
}
