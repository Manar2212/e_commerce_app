class ProductModel{
  int id;
  int price;
  int oldPrice;
  int discount;
  String name;
  String image;
  String desc;

  ProductModel({required this.id,required this.price ,required this.oldPrice,required this.discount,required this.name,required this.desc,required this.image});

  factory ProductModel.fromJson(jsonData){
    return ProductModel(id: jsonData['id'],
        price: jsonData['price'].toInt(),
        oldPrice: jsonData['old_price'].toInt(),
        discount: jsonData['discount'].toInt(),
        name: jsonData['name'].toString(),
        desc: jsonData['description'].toString(),
        image: jsonData['image'].toString());
  }
}