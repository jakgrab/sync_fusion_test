import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sync_fusion_test/data/models/chart_data.dart';
import 'package:sync_fusion_test/presentation/screens/chart_screen/chart_screen_view.dart';
import 'package:sync_fusion_test/presentation/screens/cubit/chart_cubit.dart';
import 'package:sync_fusion_test/presentation/screens/cubit/chart_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<ChartCubit>()..getTemperatureData(),
      child: const ChartsScreenView(),
    );
  }
}

class TestData {
  TestData(this.x, this.y);
  final int x;
  final int y;
}
