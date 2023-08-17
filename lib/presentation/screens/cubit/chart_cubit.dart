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

  void getDewPointData() {
    final dew = _chartRepository.getDewPointData();
    emit(state.copyWith(dewPointData: dew));
  }

  void getRangeData() {
    final minTempRange = _chartRepository.getRangeData(20);
    final maxTempRange = _chartRepository.getRangeData(30);
    final minHumRange = _chartRepository.getRangeData(20);
    final maxHumRange = _chartRepository.getRangeData(80);
    final minVpdRange = _chartRepository.getRangeData(0.2);
    final maxVpdRange = _chartRepository.getRangeData(1.4);
    final minCo2Range = _chartRepository.getRangeData(300);
    final maxCo2Range = _chartRepository.getRangeData(1500);

    emit(
      state.copyWith(
        tempRange: [minTempRange, maxTempRange],
        humRange: [minHumRange, maxHumRange],
        vpdRange: [minVpdRange, maxVpdRange],
        co2Range: [minCo2Range, maxCo2Range],
      ),
    );
  }
}
