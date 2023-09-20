// data sources

import 'package:get_it/get_it.dart';
import 'package:klasha_app/features/dashboard/data/datasource.dart';

void registerDataSources(GetIt getIt) {
  getIt.registerFactory<IGetIngredientsRemoteDataSource>(
    () => GetIngredientsRemoteDataSource(getIt()),
  );
}
