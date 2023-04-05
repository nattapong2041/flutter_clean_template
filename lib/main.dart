import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'common/app_route_name.dart';
import 'common/extension/app_theme.dart';
import 'features/main_screen.dart';
import 'features/news/presentation/view/news_screen.dart';
import 'localization/locale_view_model.dart';

void main() {
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => LocaleViewModel(const Locale('th'))),
      ],
      child:
          Consumer<LocaleViewModel>(builder: (context, localeViewModel, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Template',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('th', ''), // Thai, no country code
          ],
          locale: localeViewModel.locale,
          theme: AppTheme.mainTheme,
          darkTheme: AppTheme.darkTheme,
          routes: {
            AppRouteName.main: (context) => const MainScreen(),
            AppRouteName.home: (context) => const NewsScreen(),
            //AppRouteName.news: (context) => NewsScreen(),
            AppRouteName.login: (context) => Container(),
          },
          initialRoute: AppRouteName.main,
        );
      }),
    );
  }
}
