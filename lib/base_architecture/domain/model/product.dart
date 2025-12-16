import 'package:skycast/base_architecture/core/master_object.dart';

// File name ကို သေချာစစ်ပါ။
// ignore: must_be_immutable
class Product extends MasterObject<Product> {
  String? name;
  double? price;
  String? categoryId;
  String? categoryName;
  String? image;
  int? stock;
  int? quantity;

  Product({
    String? id,
    this.name,
    this.price,
    this.categoryId,
    this.categoryName,
    this.image,
    this.stock,
    this.quantity,
  }) : super(id: 0);

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    categoryId,
    categoryName,
    image,
    stock,
    quantity,
  ];

  @override
  Product fromMap(dynamicData) {
    return Product(
      id: dynamicData['id'],
      name: dynamicData['name'] as String,
      price: dynamicData['price'],
      categoryId: dynamicData['categoryId'] as String,
      categoryName: dynamicData['categoryName'] as String,
      image: dynamicData['image'] as String,
      stock: dynamicData['stock'],
      quantity: dynamicData['quantity'],
    );
  }

  @override
  List<Product> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Product object) {
    return {
      'id': object.id,
      'name': object.name,
      'price': object.price,
      'categoryId': object.categoryId,
      'categoryName': object.categoryName,
      'image': object.image,
      'stock': object.stock,
      'productId': object.id,
      'quantity': object.quantity,
    };
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<MasterObject> objectList) {
    throw UnimplementedError();
  }

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? categoryId,
    String? categoryName,
    String? image,
    int? stock,
    int? quantity,
  }) {
    return Product(
      id: "",
      name: name ?? this.name,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      image: image ?? this.image,
      stock: stock ?? this.stock,
      quantity: quantity ?? this.quantity,
    );
  }
}
