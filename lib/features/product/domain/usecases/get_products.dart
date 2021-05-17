import 'package:ecommerce/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class GetProducts extends UseCase<List<Product>, NoParams> {
  final ProductRepository productRepository;
  GetProducts({@required this.productRepository});

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return productRepository.getProducts();
  }
}
