import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChartsApp extends StatelessWidget {
  const ChartsApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp.router(
      title: 'Sync Fusion Test',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xff090d19),
      ),
      themeMode: ThemeMode.dark,
      routerConfig: Modular.routerConfig,
    );
  }
}
