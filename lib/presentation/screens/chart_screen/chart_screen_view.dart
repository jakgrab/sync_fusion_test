import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late TrackballBehavior _trackballBehavior, _trackballBehavior2;

  double axisVisibleMin = 1, axisVisibleMax = 10;
  double chartZoomPosition = 0.5, chartZoomFactor = 0.2;

  bool isLoaded = false;
  int? selectedPointIndex;

  @override
  void initState() {
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
                  data: state.tempData,
                  trackballBehavior: _trackballBehavior,
                  synchronizeTrackballs: (trackArgs) {
                    _trackballBehavior2.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  },
                  onZoom: onZoom,
                  onChartTapped: (touchArgs) {
                    // _trackballBehavior2.showByIndex(touchArgs.position.dx.round());
                    _trackballBehavior2.show(touchArgs.position.dx, touchArgs.position.dy, 'pixel');
                  },
                  onTrackballPositionChanging: (trackArgs) {
                    if (trackArgs.chartPointInfo.dataPointIndex != null) {
                      // _trackballBehavior2.showByIndex(trackArgs.chartPointInfo.dataPointIndex!);
                      // _trackballBehavior2.showByIndex(trackArgs.chartPointInfo.dataPointIndex!);
                    }
                  },
                  chartZoomFactor: chartZoomFactor,
                  chartZoomPosition: chartZoomPosition,
                ),
                Humidity(
                  seriesColor: Colors.red,
                  data: state.tempData,
                  trackballBehavior: _trackballBehavior2,
                  synchronizeTrackballs: (trackArgs) {
                    _trackballBehavior.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  },
                  onZoom: onZoom,
                  onChartTapped: (touchArgs) {
                    // _trackballBehavior.showByIndex(touchArgs.position.dx.round());
                    _trackballBehavior.show(touchArgs.position.dx, touchArgs.position.dy, 'pixel');
                  },
                  onTrackballPositionChanging: (trackArgs) {
                    if (trackArgs.chartPointInfo.dataPointIndex != null) {
                      // _trackballBehavior.showByIndex(trackArgs.chartPointInfo.dataPointIndex!);
                    }
                  },
                  chartZoomFactor: chartZoomFactor,
                  chartZoomPosition: chartZoomPosition,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void onZoom(ZoomPanArgs zoomArgs) {
    if (zoomArgs.axis?.name == 'primaryXAxis') {
      setState(() {
        chartZoomFactor = zoomArgs.currentZoomFactor;
        chartZoomPosition = zoomArgs.currentZoomPosition;
      });
    }
  }

  void setTrackballPosition(TrackballArgs trackballArgs) {
    setState(() {
      selectedPointIndex = trackballArgs.chartPointInfo.dataPointIndex;
    });
  }

  TrackballBehavior getTrackballBehavior() => TrackballBehavior(
        activationMode: ActivationMode.singleTap,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        tooltipAlignment: ChartAlignment.near,
        enable: true,
        shouldAlwaysShow: true,
        tooltipSettings: const InteractiveTooltip(enable: true, arrowLength: 0, arrowWidth: 0),
      );
}
