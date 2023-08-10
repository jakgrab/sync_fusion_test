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

  void getHumidityData() {
    final humidity = _chartRepository.getHumidityData();
    emit(state.copyWith(humidityData: humidity));
  }

  void getVpdData() {
    final vpd = _chartRepository.getVpdData();
    emit(state.copyWith(vpdData: vpd));
  }

  void getCO2Data() {
    final co2 = _chartRepository.getCO2Data();
    emit(state.copyWith(co2Data: co2));
  }
}
