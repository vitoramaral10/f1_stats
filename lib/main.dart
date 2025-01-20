import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'main/routes.dart';

Future<void> main() async {
  // init intl
  Intl.defaultLocale = 'pt_BR';
  await initializeDateFormatting('pt_BR', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'F1 Stats',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFD70000)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD70000),
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      initialRoute: Routes.initial,
      getPages: Routes.pages,
      locale: const Locale('pt', 'BR'),
    );
  }
}
