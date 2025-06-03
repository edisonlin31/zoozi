import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoozitest/base/utils/app_text_styles.dart';
import 'package:zoozitest/base/utils/colors.dart';
import 'package:zoozitest/controllers/language_controller.dart';
import 'package:zoozitest/controllers/theme_controller.dart';
import 'package:zoozitest/l10n/app_localizations.dart';
import 'package:zoozitest/router/router/router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends ConsumerStatefulWidget {
  const App({super.key});
  @override
  createState() => _App();
}

class _App extends ConsumerState<App> {
  final _router = AppRouter(navigatorKey: navigatorKey);

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(languageProvider);
    return MaterialApp.router(
      title: "Test App",
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      routerConfig: _router.config(),
      locale: locale.languageCode == 'system' ? null : locale,
      supportedLocales: const [Locale('en'), Locale('id')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.lightGrey,
        textTheme: GoogleFonts.openSansTextTheme(ThemeData.light().textTheme),
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          titleTextStyle: AppTextStyles.medium(
            fontSize: 16,
            color: Colors.black,
          ),
          elevation: 0.3,
          iconTheme: const IconThemeData(color: AppColors.primary),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.openSansTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.teal,
        colorScheme: ColorScheme.dark(
          primary: Colors.teal,
          secondary: Colors.tealAccent,
        ),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.black,
          titleTextStyle: AppTextStyles.medium(
            fontSize: 16,
            color: Colors.white,
          ),
          elevation: 0.3,
          iconTheme: const IconThemeData(color: Colors.tealAccent),
        ),
      ),
      themeMode: themeMode,
    );
  }
}
