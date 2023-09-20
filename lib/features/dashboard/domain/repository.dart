import 'package:dartz/dartz.dart';
import 'package:klasha_app/core/error/failure.dart';
import 'package:klasha_app/core/repository/repository.dart';
import 'package:klasha_app/features/dashboard/data/datasource.dart';
import 'package:klasha_app/features/dashboard/data/model/ingredients.dart';
import 'package:klasha_app/features/dashboard/data/model/recipes.dart';

class IngredientsRepository extends Repository {
  IngredientsRepository({
    required this.remoteDataSource,
  });

  final IGetIngredientsRemoteDataSource remoteDataSource;

  Future<Either<Failure, List<IngredientsModel>>> getIngredients() async {
    return runGuard(() async {
      final response = await remoteDataSource.getIngredients();

      return response;
    });
  }

  Future<Either<Failure, List<GetRecipesModel>>> getRecipes(
      String recipes) async {
    return runGuard(() async {
      final response = await remoteDataSource.getRecipes(recipes);

      return response;
    });
  }
}
