import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/features/product/data/datasource/product_remote_data_source.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  ProductRepositoryImpl({@required this.productRemoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      return Right(await productRemoteDataSource.getProducts());
    } catch (e) {
      return Left(UnExpectedFailure());
    }
  }
}
