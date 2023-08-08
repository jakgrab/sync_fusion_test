import 'package:flutter/material.dart';
import 'package:sync_fusion_test/data/models/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Temperature extends StatefulWidget {
  const Temperature({
    super.key,
    this.seriesColor,
    required this.data,
    required this.zoomPanBehavior,
    required this.trackballBehavior,
    required this.performSwipe,
    required this.synchronizeTrackballs,
    required this.axisVisibleMin,
    required this.axisVisibleMax,
  });
  final Color? seriesColor;
  final List<ChartData> data;
  final ZoomPanBehavior zoomPanBehavior;
  final TrackballBehavior trackballBehavior;
  final void Function(ChartSwipeDirection, List<ChartData>) performSwipe;
  final void Function(ChartTouchInteractionArgs) synchronizeTrackballs;
  final double? axisVisibleMax;
  final double? axisVisibleMin;

  @override
  State<Temperature> createState() => TemperatureState();
}

class TemperatureState extends State<Temperature> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: widget.zoomPanBehavior,
      trackballBehavior: widget.trackballBehavior,
      onPlotAreaSwipe: (direction) => widget.performSwipe(direction, widget.data),
      onChartTouchInteractionMove: (tapArgs) => widget.synchronizeTrackballs(tapArgs),
      primaryXAxis: CategoryAxis(
        visibleMinimum: widget.axisVisibleMin,
        visibleMaximum: widget.axisVisibleMax,
        maximumLabelWidth: 1,
      ),
      series: <ChartSeries>[
        SplineSeries<ChartData, String>(
          color: widget.seriesColor,
          dataSource: widget.data,
          xValueMapper: (ChartData data, _) => data.time,
          yValueMapper: (ChartData data, _) => data.data,
        )
      ],
    );
  }
}

// class Humidity extends StatefulWidget {
//   const Humidity({
//     super.key,
//     this.seriesColor,
//     required this.data,
//     required this.zoomPanBehavior,
//     required this.trackballBehavior,
//     required this.performSwipe,
//     required this.synchronizeTrackballs,
//     required this.axisVisibleMin,
//     required this.axisVisibleMax,
//   });
//   final Color? seriesColor;
//   final List<ChartData> data;
//   final ZoomPanBehavior zoomPanBehavior;
//   final TrackballBehavior trackballBehavior;
//   final void Function(ChartSwipeDirection, List<ChartData>) performSwipe;
//   final void Function(ChartTouchInteractionArgs) synchronizeTrackballs;
//   final double? axisVisibleMax;
//   final double? axisVisibleMin;

//   @override
//   State<Humidity> createState() => HumidityState();
// }

// class HumidityState extends State<Humidity> {
//   @override
//   Widget build(BuildContext context) {
//     return SfCartesianChart(
//       zoomPanBehavior: widget.zoomPanBehavior,
//       trackballBehavior: widget.trackballBehavior,
//       onPlotAreaSwipe: (direction) => widget.performSwipe(direction, widget.data),
//       onChartTouchInteractionMove: (tapArgs) => widget.synchronizeTrackballs(tapArgs),
//       primaryXAxis: CategoryAxis(
//         visibleMinimum: widget.axisVisibleMin,
//         visibleMaximum: widget.axisVisibleMax,
//         maximumLabelWidth: 1,
//       ),
//       series: <ChartSeries>[
//         SplineSeries<ChartData, String>(
//           color: widget.seriesColor,
//           dataSource: widget.data,
//           xValueMapper: (ChartData data, _) => data.time,
//           yValueMapper: (ChartData data, _) => data.data,
//         )
//       ],
//     );
//   }
// }
