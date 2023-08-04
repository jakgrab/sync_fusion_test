import 'package:sync_fusion_test/data/models/chart_data.dart';

abstract class ChartRepositoryInterface {
  List<String> generateTimeList();

  List<ChartData> getTemperatureData();
}
