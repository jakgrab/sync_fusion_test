import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChartsApp extends StatelessWidget {
  const ChartsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sync Fusion Test',
      theme: ThemeData(primarySwatch: Colors.purple),
      routerConfig: Modular.routerConfig,
    );
  }
}
