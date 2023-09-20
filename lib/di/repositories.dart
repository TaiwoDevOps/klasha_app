// Repositories
import 'package:get_it/get_it.dart';
import 'package:klasha_app/features/dashboard/domain/repository.dart';

void registerRepositories(GetIt getIt) {
  getIt.registerFactory(
    () => IngredientsRepository(
      remoteDataSource: getIt(),
    ),
  );
}
