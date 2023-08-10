import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sync_fusion_test/presentation/screens/chart_screen/widgets/co2_chart.dart';
import 'package:sync_fusion_test/presentation/screens/chart_screen/widgets/humidity_chart.dart';
import 'package:sync_fusion_test/presentation/screens/chart_screen/widgets/temperature_chart.dart';
import 'package:sync_fusion_test/presentation/screens/chart_screen/widgets/vpd_chart.dart';
import 'package:sync_fusion_test/presentation/screens/cubit/chart_cubit.dart';
import 'package:sync_fusion_test/presentation/screens/cubit/chart_state.dart';
import 'package:sync_fusion_test/utils/extensions/list_operations_on_chart_data_list.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsScreenView extends StatefulWidget {
  const ChartsScreenView({super.key});

  @override
  State<ChartsScreenView> createState() => _ChartsScreenViewState();
}

class _ChartsScreenViewState extends State<ChartsScreenView> {
  late TrackballBehavior _trackballBehaviorTemp, _trackballBehaviorHum, _trackballBehaviorVpd, _trackballBehaviorCO2;

  double axisVisibleMin = 1, axisVisibleMax = 10;
  double chartZoomPosition = 0.0, chartZoomFactor = 0.02;

  bool isLoaded = false;
  int? selectedPointIndex;

  @override
  void initState() {
    _trackballBehaviorTemp = getTrackballBehavior(
        // format: (trackballDetails) {
        //   // return trackballDetails.point != null
        //   //     ? "${trackballDetails.point!.y.toString()}°C@${trackballDetails.point!.x.toString()}"
        //   //     : "";

        //   return "${trackballDetails.point?.label.toString()}°C@${trackballDetails.point?.x.toString()}";
        // },

        format: 'point.y°C@point.x',
        decimalPlacesNum: 0);
    _trackballBehaviorHum = getTrackballBehavior(
        // format: (trackballDetails) {
        //   // return trackballDetails.point != null
        //   //     ? "${trackballDetails.point!.y.toString()}%@${trackballDetails.point!.x.toString()}"
        //   //     : "";
        //   return "${trackballDetails.point?.y.toString()}%@${trackballDetails.point?.x.toString()}";
        // },
        format: 'point.y%@point.x',
        decimalPlacesNum: 0);

    _trackballBehaviorVpd = getTrackballBehavior(format: 'point.y@point.x');
    _trackballBehaviorCO2 = getTrackballBehavior(format: 'point.y@point.x', decimalPlacesNum: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ChartCubit, ChartState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Temperature(
                  //   data: state.tempData,
                  //   trackballBehavior: _trackballBehaviorTemp,
                  //   // synchronizeTrackballs: (trackArgs) {
                  //   //   _trackballBehaviorHum.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   //   _trackballBehaviorVpd.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   //   _trackballBehaviorCO2.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   // },
                  //   onZoom: onZoom,
                  //   onChartTapped: (touchArgs) {
                  //     _trackballBehaviorHum.show(touchArgs.position.dx, touchArgs.position.dy, 'pixel');
                  //     _trackballBehaviorVpd.show(touchArgs.position.dx, touchArgs.position.dy, 'pixel');
                  //     _trackballBehaviorCO2.show(touchArgs.position.dx, touchArgs.position.dy, 'pixel');
                  //   },
                  //   chartZoomFactor: chartZoomFactor,
                  //   chartZoomPosition: chartZoomPosition,
                  // ),
                  // Humidity(
                  //   seriesColor: Colors.red,
                  //   data: state.humidityData,
                  //   trackballBehavior: _trackballBehaviorHum,
                  //   // synchronizeTrackballs: (trackArgs) {
                  //   //   _trackballBehaviorTemp.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   //   _trackballBehaviorVpd.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   //   _trackballBehaviorCO2.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   // },
                  //   onZoom: onZoom,
                  //   onChartTapped: (touchArgs) {
                  //     _trackballBehaviorTemp.show(touchArgs.position.dx, touchArgs.position.dy, 'pixel');
                  //     _trackballBehaviorVpd.show(touchArgs.position.dx, touchArgs.position.dy, 'pixel');
                  //     _trackballBehaviorCO2.show(touchArgs.position.dx, touchArgs.position.dy, 'pixel');
                  //   },
                  //   chartZoomFactor: chartZoomFactor,
                  //   chartZoomPosition: chartZoomPosition,
                  // ),
                  // VPD(
                  //   data: state.vpdData,
                  //   trackballBehavior: _trackballBehaviorVpd,
                  //   onZoom: onZoom,
                  //   // synchronizeTrackballs: (trackArgs) {
                  //   //   _trackballBehaviorTemp.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   //   _trackballBehaviorHum.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   //   _trackballBehaviorCO2.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   // },
                  //   onChartTapped: (trackArgs) {
                  //     _trackballBehaviorTemp.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //     _trackballBehaviorHum.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //     _trackballBehaviorCO2.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   },
                  //   chartZoomFactor: chartZoomFactor,
                  //   chartZoomPosition: chartZoomPosition,
                  // ),

                  // CO2(
                  //   title: 'CO2: ${state.co2Data.last.data.toInt()}ppm',
                  //   data: state.co2Data,
                  //   trackballBehavior: _trackballBehaviorCO2,
                  //   seriesColor: Colors.black,
                  //   onZoom: onZoom,
                  //   // synchronizeTrackballs: (trackArgs) {
                  //   //   _trackballBehaviorTemp.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   //   _trackballBehaviorHum.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   //   _trackballBehaviorVpd.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   // },
                  //   // onTrackballPositionChanging: (_) {},
                  //   onChartTapped: (trackArgs) {
                  //     _trackballBehaviorTemp.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //     _trackballBehaviorHum.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //     _trackballBehaviorVpd.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                  //   },
                  //   chartZoomFactor: chartZoomFactor,
                  //   chartZoomPosition: chartZoomPosition,
                  // ),
                  CustomChart(
                    title: 'Temperature: ${state.tempData.last.data.toInt()}°C',
                    data: state.tempData,
                    rangeData: state.tempRange,
                    max: state.tempData.maxValue,
                    min: state.tempData.minValue,
                    average: state.tempData.meanValue,
                    trackballBehavior: _trackballBehaviorTemp,
                    onZoom: onZoom,
                    onChartTapped: (trackArgs) {
                      _trackballBehaviorCO2.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                      _trackballBehaviorHum.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                      _trackballBehaviorVpd.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                    },
                    chartZoomFactor: chartZoomFactor,
                    chartZoomPosition: chartZoomPosition,
                    pointColorMapper: (data, _) {
                      if (data.data <= 25.0) {
                        return Colors.purple;
                      } else if (data.data > 25.0 && data.data <= 27.0) {
                        return Colors.green;
                      } else if (data.data > 27.0) {
                        return Colors.red;
                      }
                      return Colors.greenAccent;
                    },
                  ),
                  CustomChart(
                    title: 'Humidity: ${state.humidityData.last.data.toInt()}%',
                    data: state.humidityData,
                    max: state.humidityData.maxValue,
                    min: state.humidityData.minValue,
                    average: state.humidityData.meanValue,
                    trackballBehavior: _trackballBehaviorHum,
                    onZoom: onZoom,
                    onChartTapped: (trackArgs) {
                      _trackballBehaviorTemp.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                      _trackballBehaviorCO2.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                      _trackballBehaviorVpd.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                    },
                    chartZoomFactor: chartZoomFactor,
                    chartZoomPosition: chartZoomPosition,
                    pointColorMapper: (data, _) {
                      if (data.data <= 25.0 || (data.data > 70.0 && data.data <= 80)) {
                        return Colors.purple;
                      } else if (data.data > 80) {
                        return Colors.red;
                      }
                      return Colors.greenAccent;
                    },
                  ),
                  CustomChart(
                    title: 'VPD: ${state.vpdData.last.data.toInt()}',
                    data: state.vpdData,
                    max: state.vpdData.maxValue,
                    min: state.vpdData.minValue,
                    average: state.vpdData.meanValue,
                    trackballBehavior: _trackballBehaviorVpd,
                    onZoom: onZoom,
                    onChartTapped: (trackArgs) {
                      _trackballBehaviorTemp.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                      _trackballBehaviorHum.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                      _trackballBehaviorCO2.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                    },
                    chartZoomFactor: chartZoomFactor,
                    chartZoomPosition: chartZoomPosition,
                    pointColorMapper: (data, _) {
                      if (data.data <= 1.0 || data.data > 1.5) {
                        return Colors.purple;
                      }
                      return Colors.greenAccent;
                    },
                  ),
                  CustomChart(
                    title: 'CO2: ${state.co2Data.last.data.toInt()}ppm',
                    data: state.co2Data,
                    max: state.co2Data.maxValue,
                    min: state.co2Data.minValue,
                    average: state.co2Data.meanValue,
                    trackballBehavior: _trackballBehaviorCO2,
                    seriesColor: Colors.black,
                    onZoom: onZoom,
                    onChartTapped: (trackArgs) {
                      _trackballBehaviorTemp.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                      _trackballBehaviorHum.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                      _trackballBehaviorVpd.show(trackArgs.position.dx, trackArgs.position.dy, 'pixel');
                    },
                    chartZoomFactor: chartZoomFactor,
                    chartZoomPosition: chartZoomPosition,
                  )
                ],
              ),
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

  TrackballBehavior getTrackballBehavior({Color? color, int? decimalPlacesNum, required String format}) =>
      TrackballBehavior(
        activationMode: ActivationMode.singleTap,
        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
        // tooltipAlignment: ChartAlignment.center,
        enable: true,
        shouldAlwaysShow: true,
        // builder: (context, trackballDetails) => Container(
        //   color: Colors.green,
        //   height: 30,
        //   width: 60,
        //   child: Text(format),
        // ),

        tooltipSettings: InteractiveTooltip(
          decimalPlaces: decimalPlacesNum ?? 2,
          color: color,
          enable: true,
          arrowLength: 0,
          arrowWidth: 0,
          format: format,
        ),
      );
}
