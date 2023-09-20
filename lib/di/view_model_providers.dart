// View models
import 'package:get_it/get_it.dart';
import 'package:klasha_app/features/dashboard/presentation/viewmodel/dashboard_vm.dart';

void registerViewModelProviders(GetIt getIt) {
  getIt.registerFactory(
    () => DashboardVM(
      ingredientsRepository: getIt(),
    ),
  );
}
