import 'package:ecommerce/features/product/data/models/product_MODEL.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(Duration(seconds: 2));

    //REMOVE BELOW CODE & CONNECT API
    List<ProductModel> products = [];
    for (int i = 0; i < 15; i++) {
      products.add(ProductModel.fromJson(
          {"id": "${i + 1}", "name": "Product ${i + 1}"}));
    }

    return products;
  }
}
