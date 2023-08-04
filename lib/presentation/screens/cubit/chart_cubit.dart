import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sync_fusion_test/data/repository/chart_repository_interface.dart';
import 'package:sync_fusion_test/presentation/screens/cubit/chart_state.dart';

class ChartCubit extends Cubit<ChartState> {
  ChartCubit(
    this._chartRepository,
  ) : super(ChartState());

  final ChartRepositoryInterface _chartRepository;

  void getTemperatureData() {
    final temp = _chartRepository.getTemperatureData();
    emit(state.copyWith(tempData: temp));
  }
}
