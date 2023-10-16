import 'package:get_it/get_it.dart';

import 'app_setting_injection.dart';
import 'domain_injection.dart';
import 'model_injection.dart';
import 'presenter_injection.dart';

final GetIt injector = GetIt.instance;

/// Initialize all dependencies with injections
Future<void> initializeDependencies() async {
  AppSettingInjection.inject();
  ModelInjection.inject();
  DomainInjection.inject();
  PresenterInjection.inject();
}
