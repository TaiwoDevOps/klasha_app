import 'package:klasha_app/core/error/exception.dart';
import 'package:klasha_app/core/managers/api_endpoints.dart';
import 'package:klasha_app/core/managers/http_manager.dart';
import 'package:klasha_app/features/dashboard/data/model/recipes.dart';

import 'model/ingredients.dart';

abstract class IGetIngredientsRemoteDataSource {
  Future<List<IngredientsModel>> getIngredients();
  Future<List<GetRecipesModel>> getRecipes(List<String> recipes);
}

class GetIngredientsRemoteDataSource
    implements IGetIngredientsRemoteDataSource {
  GetIngredientsRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<List<IngredientsModel>> getIngredients() async {
    try {
      final response = await http.get(recipeEndpoints.getIngredients);
      if (response != null) {
        final data = response as List;
        return data.map((item) => IngredientsModel.fromJson(item)).toList();
      }
      throw KlashaServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<GetRecipesModel>> getRecipes(List<String> recipes) async {
    try {
      final response = await http.get(recipeEndpoints.getRecipes(recipes));
      if (response != null) {
        final data = response as List;
        return data.map((item) => GetRecipesModel.fromJson(item)).toList();
      }
      throw KlashaServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }
}
