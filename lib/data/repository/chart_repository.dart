import 'dart:math';

import 'package:sync_fusion_test/data/models/chart_data.dart';
import 'package:sync_fusion_test/data/repository/chart_repository_interface.dart';

class ChartRepository implements ChartRepositoryInterface {
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
    final timeList = generateTimeList();

    return timeList.map((time) {
      double randomData = Random().nextDouble() * 40.0;
      return ChartData(time: time, data: randomData);
    }).toList();
  }
}
