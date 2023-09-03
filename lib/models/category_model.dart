class CategoryModel{
  int id;
  String name;
  String image;

  CategoryModel({required this.id,required this.image,required this.name});

  factory CategoryModel.fromJson(jsonData){
    return CategoryModel(id: jsonData['id'],
        image: jsonData['image'],
        name: jsonData['name']);
  }
}