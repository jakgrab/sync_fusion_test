import 'package:flutter/material.dart';
import 'package:sync_fusion_test/data/models/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CO2 extends StatefulWidget {
  const CO2({
    super.key,
    this.seriesColor,
    required this.data,
    required this.trackballBehavior,
    required this.onZoom,
    required this.synchronizeTrackballs,
    required this.onTrackballPositionChanging,
    required this.onChartTapped,
    required this.chartZoomFactor,
    required this.chartZoomPosition,
  });

  final Color? seriesColor;
  final List<ChartData> data;

  final TrackballBehavior trackballBehavior;
  final void Function(ZoomPanArgs) onZoom;
  final void Function(ChartTouchInteractionArgs) synchronizeTrackballs;
  final void Function(ChartTouchInteractionArgs) onChartTapped;

  final void Function(TrackballArgs trackballArgs) onTrackballPositionChanging;

  final double? chartZoomFactor;
  final double? chartZoomPosition;

  @override
  State<CO2> createState() => CO2State();
}

class CO2State extends State<CO2> {
  late ZoomPanBehavior _zoomPanBehavior;

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
      title: ChartTitle(text: 'CO2: ${widget.data.last.data.toInt()}ppm', alignment: ChartAlignment.near),
      zoomPanBehavior: _zoomPanBehavior,
      trackballBehavior: widget.trackballBehavior,
      onZooming: widget.onZoom,
      onChartTouchInteractionMove: (tapArgs) => widget.synchronizeTrackballs(tapArgs),
      onTrackballPositionChanging: widget.onTrackballPositionChanging,
      onChartTouchInteractionUp: widget.onChartTapped,
      primaryXAxis: CategoryAxis(
        isVisible: false,
        zoomFactor: widget.chartZoomFactor,
        zoomPosition: widget.chartZoomPosition,
        name: 'primaryXAxis',
        // maximumLabelWidth: 1,
      ),
      primaryYAxis: NumericAxis(
        // title: AxisTitle(text: "CO2"),
        isVisible: false,
        // zoomFactor: widget.chartZoomFactor,
        // zoomPosition: widget.chartZoomPosition,
        name: 'primaryYAxis',
        // maximumLabelWidth: 1,
      ),
      series: <ChartSeries>[
        SplineSeries<ChartData, String>(
          color: widget.seriesColor,
          dataSource: widget.data,
          xValueMapper: (ChartData data, _) => data.time,
          yValueMapper: (ChartData data, _) => data.data,
          // pointColorMapper: (data, _) {
          //   return Colors.black;
          // },
        )
      ],
    );
  }
}
