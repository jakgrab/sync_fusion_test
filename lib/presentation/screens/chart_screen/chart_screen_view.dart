import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sync_fusion_test/data/models/chart_data.dart';
import 'package:sync_fusion_test/presentation/screens/chart_screen/widgets/spline_chart.dart';
import 'package:sync_fusion_test/presentation/screens/cubit/chart_cubit.dart';
import 'package:sync_fusion_test/presentation/screens/cubit/chart_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsScreenView extends StatefulWidget {
  const ChartsScreenView({super.key});

  @override
  State<ChartsScreenView> createState() => _ChartsScreenViewState();
}

class _ChartsScreenViewState extends State<ChartsScreenView> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior, _trackballBehavior2;

  // final temperatureKey = GlobalKey<TemperatureState>();
  // final humidityKey = GlobalKey<HumidityState>();

  double axisVisibleMin = 1, axisVisibleMax = 10;
  bool isLoaded = false;
  int? selectedPointIndex;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      zoomMode: ZoomMode.x,
    );
    _trackballBehavior = getTrackballBehavior();
    _trackballBehavior2 = getTrackballBehavior();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ChartCubit, ChartState>(
          builder: (context, state) {
            return Column(
              children: [
                Temperature(
                  // key: temperatureKey,
                  data: state.tempData,
                  zoomPanBehavior: _zoomPanBehavior,
                  trackballBehavior: _trackballBehavior,
                  performSwipe: performSwipe,
                  synchronizeTrackballs: (trackArgs) {
                    _trackballBehavior2.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  },
                  axisVisibleMin: axisVisibleMin,
                  axisVisibleMax: axisVisibleMax,
                ),
                Temperature(
                  // key: humidityKey,
                  seriesColor: Colors.red,
                  data: state.tempData,
                  zoomPanBehavior: _zoomPanBehavior,
                  trackballBehavior: _trackballBehavior2,
                  synchronizeTrackballs: (trackArgs) {
                    _trackballBehavior.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  },
                  performSwipe: performSwipe,
                  axisVisibleMin: axisVisibleMin,
                  axisVisibleMax: axisVisibleMax,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void performSwipe(ChartSwipeDirection direction, List<ChartData> chartData) {
    if (direction == ChartSwipeDirection.end && (axisVisibleMax + 5.toDouble()) < chartData.length) {
      isLoaded = true;
      setState(() {
        axisVisibleMin = axisVisibleMin + 5.toDouble();
        axisVisibleMax = axisVisibleMax + 5.toDouble();
      });
    } else if (direction == ChartSwipeDirection.start && (axisVisibleMin - 5.toDouble()) >= 0) {
      setState(() {
        axisVisibleMin = axisVisibleMin - 5.toDouble();
        axisVisibleMax = axisVisibleMax - 5.toDouble();
      });
    }
  }

  TrackballBehavior getTrackballBehavior() => TrackballBehavior(
        activationMode: ActivationMode.singleTap,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        tooltipAlignment: ChartAlignment.near,
        enable: true,
        // hideDelay: 5000,
        shouldAlwaysShow: true,
        tooltipSettings: const InteractiveTooltip(enable: true, arrowLength: 0, arrowWidth: 0),
      );
}
