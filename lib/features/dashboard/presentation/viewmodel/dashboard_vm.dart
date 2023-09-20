import 'package:flutter/foundation.dart';
import 'package:klasha_app/config/api_results.dart';
import 'package:klasha_app/features/dashboard/data/model/ingredients.dart';
import 'package:klasha_app/features/dashboard/data/model/recipes.dart';
import 'package:klasha_app/features/dashboard/domain/repository.dart';

class DashboardVM extends ChangeNotifier {
  DashboardVM({
    required this.ingredientsRepository,
  });

  final IngredientsRepository ingredientsRepository;

  ApiResult<List<IngredientsModel>> getIngredientsRES =
      ApiResult<List<IngredientsModel>>.idle();

  ApiResult<List<GetRecipesModel>> getRecipesRES =
      ApiResult<List<GetRecipesModel>>.idle();

  Future<void> getIngredients() async {
    getIngredientsRES = ApiResult<List<IngredientsModel>>.loading('Loading...');
    notifyListeners();
    final failureOrIngredients = await ingredientsRepository.getIngredients();

    failureOrIngredients.fold(
      (failure) {
        debugPrint(failure.message);
        getIngredientsRES = ApiResult<List<IngredientsModel>>.error(
          failure.message,
        );
      },
      (res) {
        getIngredientsRES = ApiResult<List<IngredientsModel>>.success(res);
      },
    );
    notifyListeners();
  }

  Future<void> getRecipes(List<String> recipes) async {
    getRecipesRES = ApiResult<List<GetRecipesModel>>.loading('Loading...');
    notifyListeners();
    final failureOrIngredients =
        await ingredientsRepository.getRecipes(recipes.join(','));

    failureOrIngredients.fold(
      (failure) {
        debugPrint(failure.message);
        getRecipesRES = ApiResult<List<GetRecipesModel>>.error(
          failure.message,
        );
      },
      (res) {
        getRecipesRES = ApiResult<List<GetRecipesModel>>.success(res);
      },
    );
    notifyListeners();
  }
}
