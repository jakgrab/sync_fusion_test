import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sync_fusion_test/data/models/chart_data.dart';
import 'package:sync_fusion_test/presentation/screens/cubit/chart_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomChart extends StatefulWidget {
  const CustomChart({
    super.key,
    this.seriesColor,
    this.title,
    required this.max,
    required this.min,
    required this.average,
    required this.data,
    this.rangeData,
    required this.trackballBehavior,
    required this.onZoom,
    required this.onChartTapped,
    required this.chartZoomFactor,
    required this.chartZoomPosition,
    this.pointColorMapper,
  });

  final Color? seriesColor;
  final String? title;
  final double max;
  final double min;
  final double average;
  final List<ChartData> data;
  final List<List<ChartData>>? rangeData;
  final double? chartZoomFactor;
  final double? chartZoomPosition;
  final TrackballBehavior trackballBehavior;
  final void Function(ZoomPanArgs) onZoom;
  final void Function(ChartTouchInteractionArgs) onChartTapped;
  final Color? Function(ChartData data, int index)? pointColorMapper;

  ChartCubit getCubit(BuildContext context) => context.read<ChartCubit>();

  @override
  State<CustomChart> createState() => CustomChartState();
}

class CustomChartState extends State<CustomChart> {
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
      title: ChartTitle(text: widget.title ?? '', alignment: ChartAlignment.near),
      plotAreaBorderColor: Color(0xff090d19),
      zoomPanBehavior: _zoomPanBehavior,
      trackballBehavior: widget.trackballBehavior,
      onZooming: widget.onZoom,
      onChartTouchInteractionMove: widget.onChartTapped,
      onChartTouchInteractionUp: widget.onChartTapped,
      onTrackballPositionChanging: (trackballArgs) {
        final series = trackballArgs.chartPointInfo.series;
        if (series?.name == 'data') {
          // The way to extract the index
          // print("Index: ${trackballArgs.chartPointInfo.dataPointIndex}");
        }

        if (series?.name == 'Range') {
          trackballArgs.chartPointInfo.header = '';
          trackballArgs.chartPointInfo.label = '';
        }
      },
      primaryXAxis: CategoryAxis(
        isVisible: false,
        zoomFactor: widget.chartZoomFactor,
        zoomPosition: widget.chartZoomPosition,
        name: 'primaryXAxis',
      ),
      primaryYAxis: NumericAxis(
        isVisible: false,
        name: 'primaryYAxis',
      ),
      annotations: [
        CartesianChartAnnotation(
          widget: Container(
            child: Text(
              'Max ${widget.max}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff232d43)),
            ),
          ),
          verticalAlignment: ChartAlignment.center,
          horizontalAlignment: ChartAlignment.far,
          coordinateUnit: CoordinateUnit.logicalPixel,
          x: 400,
          y: 20,
        ),
        CartesianChartAnnotation(
          widget: Container(
            child: Text(
              'Avg ${widget.average}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff232d43)),
            ),
          ),
          verticalAlignment: ChartAlignment.center,
          horizontalAlignment: ChartAlignment.far,
          coordinateUnit: CoordinateUnit.logicalPixel,
          x: 400,
          y: 80,
        ),
        CartesianChartAnnotation(
          widget: Container(
            child: Text(
              'Min ${widget.min}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff232d43)),
            ),
          ),
          verticalAlignment: ChartAlignment.center,
          horizontalAlignment: ChartAlignment.far,
          coordinateUnit: CoordinateUnit.logicalPixel,
          x: 400,
          y: 140,
        )
      ],
      series: <ChartSeries>[
        SplineSeries<ChartData, String>(
          name: 'data',
          color: widget.seriesColor,
          dataSource: widget.data,
          xValueMapper: (ChartData data, _) => data.time,
          yValueMapper: (ChartData data, _) => data.data,
          pointColorMapper: widget.pointColorMapper,
        ),
        if (widget.rangeData != null) ...[
          LineSeries<ChartData, String>(
            name: 'Range',
            color: Colors.deepPurple,
            width: 0.8,
            dataSource: widget.rangeData!.first,
            xValueMapper: (ChartData data, _) => data.time,
            yValueMapper: (ChartData data, _) => data.data,
            dashArray: [2.0, 5.0],
          ),
          LineSeries<ChartData, String>(
            name: 'Range',
            color: Colors.deepPurple,
            width: 0.8,
            dataSource: widget.rangeData!.last,
            xValueMapper: (ChartData data, _) => data.time,
            yValueMapper: (ChartData data, _) => data.data,
            dashArray: [2.0, 5.0],
          )
        ],
      ],
    );
  }
}
