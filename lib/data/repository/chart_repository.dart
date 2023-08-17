import 'dart:math';

import 'package:sync_fusion_test/data/models/chart_data.dart';
import 'package:sync_fusion_test/data/repository/chart_repository_interface.dart';

class ChartRepository implements ChartRepositoryInterface {
  List<String> get timeList => generateTimeList();

  @override
  List<String> generateTimeList() {
    List<String> timeList = [];
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute++) {
        String hourStr = hour.toString().padLeft(2, '0');
        String minuteStr = minute.toString().padLeft(2, '0');
        String time = '$hourStr:$minuteStr';
        timeList.add(time);
      }
    }
    return timeList;
  }

  @override
  List<ChartData> getTemperatureData() {
    return timeList.map((time) {
      double randomData = Random().nextDouble() * (30.0 - 18.0) + 18.0;
      return ChartData(time: time, data: randomData);
    }).toList();
  }

  @override
  List<ChartData> getHumidityData() {
    return timeList.map((time) {
      double randomHumidity = Random().nextDouble() * 100.0;
      return ChartData(time: time, data: randomHumidity);
    }).toList();
  }

  @override
  List<ChartData> getVpdData() {
    return timeList.map((time) {
      double randomVpd = Random().nextDouble() * (2.0 - 0.5) + 0.5;
      return ChartData(time: time, data: randomVpd);
    }).toList();
  }

  @override
  List<ChartData> getCO2Data() {
    return timeList.map((time) {
      double randomCo2 = Random().nextInt(1600) + 800;
      return ChartData(time: time, data: randomCo2);
    }).toList();
  }

  @override
  List<ChartData> getRangeData(double offset) {
    return timeList.map((time) {
      return ChartData(time: time, data: 0.0 + offset);
    }).toList();
  }

  @override
  List<ChartData> getDewPointData() {
    return timeList.map((time) {
      double randomDew = Random().nextDouble() * (1.0 - 18.0) + 18.0;
      return ChartData(time: time, data: randomDew);
    }).toList();
  }
}
