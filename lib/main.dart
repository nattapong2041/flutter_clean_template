import 'package:flutter/material.dart';
import 'package:flutter_clean_template/features/home/presentation/view/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'common/app_route_name.dart';
import 'common/extension/app_theme.dart';
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
      child: Consumer2<LocaleViewModel, LocaleViewModel>(
          builder: (context, localeViewModel, loginViewModel, child) {
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
            AppRouteName.home: (context) => HomeScreen(),
            AppRouteName.login: (context) => Container(),
          },
          initialRoute: AppRouteName.home,
        );
      }),
    );
  }
}
