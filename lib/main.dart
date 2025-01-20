import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main/routes.dart';

void main() {
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
        ),
        useMaterial3: true,
      ),
      initialRoute: Routes.initial,
      getPages: Routes.pages,
    );
  }
}
