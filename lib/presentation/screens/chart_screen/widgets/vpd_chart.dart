import 'package:flutter/material.dart';
import 'package:sync_fusion_test/data/models/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VPD extends StatefulWidget {
  const VPD({
    super.key,
    this.seriesColor,
    required this.data,
    required this.trackballBehavior,
    required this.onZoom,
    // required this.synchronizeTrackballs,
    // required this.onTrackballPositionChanging,
    required this.onChartTapped,
    required this.chartZoomFactor,
    required this.chartZoomPosition,
  });

  final Color? seriesColor;
  final List<ChartData> data;

  final TrackballBehavior trackballBehavior;
  final void Function(ZoomPanArgs) onZoom;
  // final void Function(ChartTouchInteractionArgs) synchronizeTrackballs;
  final void Function(ChartTouchInteractionArgs) onChartTapped;

  // final void Function(TrackballArgs trackballArgs) onTrackballPositionChanging;

  final double? chartZoomFactor;
  final double? chartZoomPosition;

  @override
  State<VPD> createState() => VPDState();
}

class VPDState extends State<VPD> {
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
      zoomPanBehavior: _zoomPanBehavior,
      trackballBehavior: widget.trackballBehavior,
      onZooming: widget.onZoom,
      onChartTouchInteractionMove: widget.onChartTapped, //(tapArgs) => widget.synchronizeTrackballs(tapArgs),
      // onTrackballPositionChanging: widget.onTrackballPositionChanging,
      onChartTouchInteractionUp: widget.onChartTapped,
      primaryXAxis: CategoryAxis(
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
          pointColorMapper: (data, _) {
            if (data.data <= 1.0 || data.data > 1.5) {
              return Colors.purple;
            }
            return Colors.greenAccent;
          },
        )
      ],
    );
  }
}
