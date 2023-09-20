import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:klasha_app/core/managers/http_manager.dart';
import 'package:klasha_app/core/managers/network_manager.dart';
import 'package:klasha_app/di/datasource.dart';
import 'package:klasha_app/di/repositories.dart';
import 'package:klasha_app/di/view_model_providers.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // register data sources
  registerDataSources(sl);

  // register repositories
  registerRepositories(sl);

  // register view models

  registerViewModelProviders(sl);

  // register others
  await _registerOthers();
}

// Any other class
Future<void> _registerOthers() async {
  final connectivity = Connectivity();

  sl
    ..registerSingleton(connectivity)
    ..registerSingleton(
      HttpManager(),
    )
    ..registerSingleton(NetworkManager(sl()));
}
