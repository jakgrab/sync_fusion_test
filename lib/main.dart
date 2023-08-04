import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sync_fusion_test/app_module.dart';
import 'package:sync_fusion_test/charts_app.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const ChartsApp()));
}
