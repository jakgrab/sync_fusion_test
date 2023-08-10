import 'package:sync_fusion_test/data/models/chart_data.dart';

extension ListOperations on List<ChartData> {
  double get minValue {
    final sorted = [...this];
    sorted.sort((a, b) => a.data.compareTo(b.data));
    return sorted.first.data.floorToDouble();
  }

  double get maxValue {
    final sorted = [...this];
    sorted.sort((a, b) => b.data.compareTo(a.data));
    return sorted.first.data.floorToDouble();
  }

  double get meanValue {
    double totalValue = 0;
    for (var d in this) {
      totalValue += d.data;
    }
    return (totalValue / length).floorToDouble();
  }
}
