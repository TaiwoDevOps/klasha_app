class _RecipeEndpoints {
  final getIngredients = '/ingredients';
  String getRecipes(String recipes) => '/recipes?ingredients=$recipes';
}

final recipeEndpoints = _RecipeEndpoints();
