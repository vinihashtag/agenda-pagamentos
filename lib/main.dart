import 'package:agenda_pagamentos/core/theme/app_theme.dart';
import 'package:agenda_pagamentos/core/utils/injector_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'pages/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectorDependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LiNutri',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      home: const HomePage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      onInit: () {
        // Block preferences of orientation of app
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

        //  Initialize intl in portuguese
        Intl.defaultLocale = 'pt_BR';
      },
    );
  }
}
