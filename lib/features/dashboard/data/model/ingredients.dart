class IngredientsModel {
  String? title;
  String? useBy;

  IngredientsModel({this.title, this.useBy});

  IngredientsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    useBy = json['use-by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['use-by'] = useBy;
    return data;
  }
}
