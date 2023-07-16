import 'package:under/feature/home/bussiness/entity/product.dart';

sealed class HomeLoggedState {}

final class InitalHomeLoggedState implements HomeLoggedState {}

final class LoadingHomeLoggedState implements HomeLoggedState {}

final class SucessHomeLoggedState implements HomeLoggedState {
  List<Product> allProducts;

  SucessHomeLoggedState({required this.allProducts});
}

final class ErrorHomeLoggedState implements HomeLoggedState {
  String errorMessage;

  ErrorHomeLoggedState({required this.errorMessage});
}
