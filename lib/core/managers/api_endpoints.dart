class _RecipeEndpoints {
  final getIngredients = '/ingredients';
  String getRecipes(List<String> recipes) => '/recipes?ingredients=$recipes';
}

final recipeEndpoints = _RecipeEndpoints();
