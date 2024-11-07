import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'main/routes.dart';

Future<void> main() async {
  await initializeDateFormatting('pt_BR');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'F1 Stats',
      darkTheme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF15151E),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      initialRoute: Routes.initial,
      getPages: Routes.pages,
    );
  }
}
