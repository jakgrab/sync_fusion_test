import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sync_fusion_test/data/models/chart_data.dart';
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
  late SelectionBehavior _selectionBehavior;

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
    _selectionBehavior = SelectionBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ChartCubit, ChartState>(
          builder: (context, state) {
            return Center(
              child: Container(
                height: 200,
                child: SfCartesianChart(
                  zoomPanBehavior: _zoomPanBehavior,
                  onPlotAreaSwipe: (direction) => performSwipe(direction, state.tempData),
                  // onSelectionChanged: (args) {
                  //   // While manually selecting the points.
                  //   if (!isLoaded) {
                  //     selectedPointIndex = args.viewportPointIndex;
                  //   }
                  //   // While swiping the point gets selected.
                  //   else {
                  //     selectedPointIndex = args.pointIndex;
                  //   }
                  //   setState(() {
                  //     //Setting visible minimum and visible maximum to maintain the selected point in the center of viewport
                  //     axisVisibleMin = selectedPointIndex! - 2.toDouble();
                  //     axisVisibleMax = selectedPointIndex! + 2.toDouble();
                  //   });
                  // },
                  primaryXAxis: CategoryAxis(visibleMinimum: axisVisibleMin, visibleMaximum: axisVisibleMax),
                  series: <ChartSeries>[
                    SplineSeries<ChartData, String>(
                      dataSource: state.tempData,
                      xValueMapper: (ChartData data, d) => data.time,
                      yValueMapper: (ChartData data, _) => data.data,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void performSwipe(ChartSwipeDirection direction, List<ChartData> chartData) {
    // Executes when swiping the chart from right to left
    if (direction == ChartSwipeDirection.end && (axisVisibleMax + 5.toDouble()) < chartData.length) {
      isLoaded = true;
      setState(() {
        // set the visible minimum and visible maximum to maintain the selected point in the center of the viewport.
        axisVisibleMin = axisVisibleMin + 5.toDouble();
        axisVisibleMax = axisVisibleMax + 5.toDouble();
      });
      // To execute after chart redrawn with new visible minimum and maximum, we used delay for 1 second
      // Future.delayed(const Duration(milliseconds: 1000), () {
      //   // Public method used to select the data point dynamically
      //   _selectionBehavior.selectDataPoints((axisVisibleMin.toInt()) + 2);
      // });
    }
    // Executes when swiping the chart from left to right
    else if (direction == ChartSwipeDirection.start && (axisVisibleMin - 5.toDouble()) >= 0) {
      setState(() {
        axisVisibleMin = axisVisibleMin - 5.toDouble();
        axisVisibleMax = axisVisibleMax - 5.toDouble();
        // Future.delayed(const Duration(milliseconds: 1000), () {
        //   _selectionBehavior.selectDataPoints((axisVisibleMin.toInt()) + 2);
        // });
      });
    }
  }
}
