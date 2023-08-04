import 'package:flutter_modular/flutter_modular.dart';
import 'package:sync_fusion_test/data/repository/chart_repository.dart';
import 'package:sync_fusion_test/data/repository/chart_repository_interface.dart';
import 'package:sync_fusion_test/presentation/screens/chart_screen/chart_screen.dart';

import 'presentation/screens/cubit/chart_cubit.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<ChartRepositoryInterface>(ChartRepository.new);
    i.addLazySingleton(ChartCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const ChartsScreen());
  }
}
