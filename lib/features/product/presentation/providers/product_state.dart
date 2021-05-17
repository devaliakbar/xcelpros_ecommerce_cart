part of 'product_provider.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;
  ProductLoadedState({@required this.products});

  @override
  List<Object> get props => [products];
}

class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
