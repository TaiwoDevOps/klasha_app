import 'package:get_it/get_it.dart';
import 'package:klasha_app/features/dashboard/presentation/viewmodel/dashboard_vm.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider<DashboardVM>(
    create: (_) => GetIt.I<DashboardVM>(),
  ),
];
