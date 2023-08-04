import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sync_fusion_test/data/models/chart_data.dart';

part 'chart_state.freezed.dart';

@freezed
class ChartState with _$ChartState {
  factory ChartState({
    @Default([]) List<ChartData> tempData,
  }) = _ChartState;
}
