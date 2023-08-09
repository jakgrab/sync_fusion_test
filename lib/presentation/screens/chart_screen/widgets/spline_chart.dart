import 'package:flutter/material.dart';
import 'package:sync_fusion_test/data/models/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Temperature extends StatefulWidget {
  const Temperature({
    super.key,
    this.seriesColor,
    required this.data,
    // required this.zoomPanBehavior,
    required this.trackballBehavior,
    // required this.performSwipe,
    required this.onZoom,
    required this.synchronizeTrackballs,
    // required this.axisVisibleMin,
    // required this.axisVisibleMax,
    required this.chartZoomFactor,
    required this.chartZoomPosition,
  });

  final Color? seriesColor;
  final List<ChartData> data;
  // final ZoomPanBehavior zoomPanBehavior;
  final TrackballBehavior trackballBehavior;
  // final void Function(ChartSwipeDirection, List<ChartData>) performSwipe;
  final void Function(ZoomPanArgs) onZoom;
  final void Function(ChartTouchInteractionArgs) synchronizeTrackballs;
  // final double? axisVisibleMax;
  // final double? axisVisibleMin;
  final double? chartZoomFactor;
  final double? chartZoomPosition;

  @override
  State<Temperature> createState() => TemperatureState();
}

class TemperatureState extends State<Temperature> {
  late ZoomPanBehavior _zoomPanBehavior;
  void refreshTemperature() => setState(() {});

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      zoomMode: ZoomMode.x,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: _zoomPanBehavior,
      trackballBehavior: widget.trackballBehavior,
      onZooming: widget.onZoom,
      // onPlotAreaSwipe: (direction) => widget.performSwipe(direction, widget.data),
      onChartTouchInteractionMove: (tapArgs) => widget.synchronizeTrackballs(tapArgs),
      // onTrackballPositionChanging: (trackballArgs) => {
      //   //possible to set position on click
      // },
      primaryXAxis: CategoryAxis(
        // visibleMinimum: widget.axisVisibleMin,
        // visibleMaximum: widget.axisVisibleMax,
        zoomFactor: widget.chartZoomFactor,
        zoomPosition: widget.chartZoomPosition,
        name: 'primaryXAxis',
        // maximumLabelWidth: 1,
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

class Humidity extends StatefulWidget {
  const Humidity({
    super.key,
    this.seriesColor,
    required this.data,
    // required this.zoomPanBehavior,
    required this.trackballBehavior,
    // required this.performSwipe,
    required this.synchronizeTrackballs,
    required this.onZoom,
    // required this.axisVisibleMin,
    // required this.axisVisibleMax,
    required this.chartZoomFactor,
    required this.chartZoomPosition,
  });

  final Color? seriesColor;
  final List<ChartData> data;
  // final ZoomPanBehavior zoomPanBehavior;
  final TrackballBehavior trackballBehavior;
  // final void Function(ChartSwipeDirection, List<ChartData>) performSwipe;
  final void Function(ChartTouchInteractionArgs) synchronizeTrackballs;
  final void Function(ZoomPanArgs) onZoom;
  // final double? axisVisibleMax;
  // final double? axisVisibleMin;
  final double? chartZoomFactor;
  final double? chartZoomPosition;

  @override
  State<Humidity> createState() => HumidityState();
}

class HumidityState extends State<Humidity> {
  late ZoomPanBehavior _zoomPanBehavior;

  void refreshHumidity() => setState(() {
        print("HUMIDITY: current Z FAC: ${widget.chartZoomFactor}");
        print("HUMIDITY: current Z POS: ${widget.chartZoomPosition}");
      });

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      zoomMode: ZoomMode.x,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: _zoomPanBehavior,
      trackballBehavior: widget.trackballBehavior,
      // onPlotAreaSwipe: (direction) => widget.performSwipe(direction, widget.data),
      onChartTouchInteractionMove: (tapArgs) => widget.synchronizeTrackballs(tapArgs),
      primaryXAxis: CategoryAxis(
        // visibleMinimum: widget.axisVisibleMin,
        // visibleMaximum: widget.axisVisibleMax,
        zoomFactor: widget.chartZoomFactor,
        zoomPosition: widget.chartZoomPosition,
        name: 'primaryXAxis',
        // maximumLabelWidth: 1,
      ),
      onZooming: widget.onZoom,
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
