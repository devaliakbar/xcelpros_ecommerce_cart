import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/usecases/get_products.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'product_state.dart';

class ProductProvider extends ChangeNotifier {
  ProductState productState;
  final GetProducts _getProducts;

  ProductProvider({@required GetProducts getProducts})
      : assert(getProducts != null),
        _getProducts = getProducts,
        productState = ProductLoadingState();

  Future<void> getProduct() async {
    final Either result = await _getProducts(NoParams());

    result.fold((l) {
      productState = ProductErrorState(message: _mapFailureToMessage(l));
      notifyListeners();
    }, (r) {
      productState = ProductLoadedState(products: r);
      notifyListeners();
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      default:
        return "Oops Something went wrong";
    }
  }
}
