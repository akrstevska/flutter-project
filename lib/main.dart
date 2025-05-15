import 'dart:io';

import 'screens/home_page.dart';
import 'utilities/birthday_data.dart';
import '../../utilities/notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initializeDataSystem().then((value) => FlutterNativeSplash.remove());

  runApp(MaterialApp(
    home: const BDReminderApp(),
    title: "UACS B-Day",
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', ''),
      Locale('mk', ''),
      Locale('de', ''),
    ],
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    navigatorKey: navigatorKey,
  ));
}

class BDReminderApp extends StatefulWidget {
  const BDReminderApp({Key? key}) : super(key: key);

  @override
  State<BDReminderApp> createState() => _BDReminderAppState();
}

class _BDReminderAppState extends State<BDReminderApp> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
