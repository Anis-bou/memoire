import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blogapp/provider/locale_provider.dart';
import 'package:blogapp/provider/theme_provider.dart';
import 'package:blogapp/route.dart';

import 'package:blogapp/screens/agence/home.dart';
import 'package:blogapp/screens/client/clientDrawer.dart';
import 'package:blogapp/screens/client/screens/HomeClient.dart';
import 'package:blogapp/screens/main/main_screen.dart';
import 'package:blogapp/splash%20screens/onboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'utils/constants.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  print('initScreen ${initScreen}');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider())
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  static const String title = 'IMMOBILIA';

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          final provider = Provider.of<LocaleProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            initialRoute: initScreen == 0 || initScreen == null ? "first" : "/",
            routes: {
              '/': (context) => AnimatedSplashScreen(
                    backgroundColor: COLOR_2,
                    splash: Container(
                      child: Lottie.asset("assets/animations/splashscreen.json",
                          height: 400),
                    ),
                    duration: 1000,
                    splashTransition: SplashTransition.fadeTransition,
                    nextScreen: OnboardingScreen(),
                  ),
              "first": (context) => AnimatedSplashScreen(
                    backgroundColor: COLOR_2,
                    splash: Container(
                      child: Lottie.asset("assets/animations/splashscreen.json",
                          height: 400),
                    ),
                    duration: 1000,
                    splashTransition: SplashTransition.fadeTransition,
                    nextScreen: OnboardingScreen(),
                  ),
            },
          );
        },
      );
}
