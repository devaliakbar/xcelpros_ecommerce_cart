import 'package:ecommerce/features/cart/presentation/providers/cart_provider.dart';
import 'package:ecommerce/features/product/data/datasource/product_remote_data_source.dart';
import 'package:ecommerce/features/product/data/repositories/product_repository.dart';
import 'package:ecommerce/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce/features/product/domain/usecases/get_products.dart';
import 'package:ecommerce/features/product/presentation/providers/product_provider.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core

  //! External

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////
  // 1 PRODUCT
  // Bloc
  sl.registerFactory<ProductProvider>(
    () => ProductProvider(getProducts: sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetProducts(productRepository: sl()));
  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(productRemoteDataSource: sl()),
  );
  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////
  // 2 CART
  // Provider
  sl.registerFactory<CartProvider>(
    () => CartProvider(),
  );
}
