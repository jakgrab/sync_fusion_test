import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sync_fusion_test/data/models/chart_data.dart';

part 'chart_state.freezed.dart';

@freezed
class ChartState with _$ChartState {
  factory ChartState({
    @Default([]) List<ChartData> tempData,
    @Default([]) List<ChartData> humidityData,
    @Default([]) List<ChartData> vpdData,
    @Default([]) List<ChartData> co2Data,
  }) = _ChartState;
}
