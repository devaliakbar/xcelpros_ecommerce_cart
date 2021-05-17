import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductModel extends Product {
  ProductModel({@required String id, @required String name})
      : super(id: id, name: name);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(id: json['id'], name: json['name']);
  }
}
