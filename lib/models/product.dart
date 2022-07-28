import 'package:cloud_firestore/cloud_firestore.dart';

class Product {

  String author;
  String name;
  String image;

  String? referenceID;

  Product(this.name, this.author, this.image, {this.referenceID});

  Map<String, dynamic> toJson() => _productToJson(this);

  factory Product.fromJson(Map<String, dynamic> json) => _productFromJson(json);

  @override
  String toString() => 'Product<$name>';
}

Product _productFromJson(Map<String, dynamic> json) {
  return Product(json['name'] as String,
      json['author'] as String,
      json['image'] as String);

}

Map<String, dynamic> _productToJson(Product instance) => <String, dynamic>{
  'name': instance.name,
  'author': instance.author,
  'image': instance.image,
};