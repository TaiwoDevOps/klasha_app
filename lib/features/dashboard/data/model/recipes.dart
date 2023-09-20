class GetRecipesModel {
  String? title;
  List<String>? ingredients;

  GetRecipesModel({this.title, this.ingredients});

  GetRecipesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    ingredients = json['ingredients'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['ingredients'] = ingredients;
    return data;
  }
}
