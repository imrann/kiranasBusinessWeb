import 'package:flutter/material.dart';
import 'package:kiranas_business_web/Podo/Product.dart';

class ProductListState extends ChangeNotifier {
  List<Product> productListState = [];

  List<Product> getProductListState() => productListState;

  setProductListState(List<Product> productListState) {
    print("prooo :" + productListState.toString());
    this.productListState = productListState;
    notifyListeners();
  }

  List<Product> productState = [];

  List<Product> getProductState() => productState;

  setProductState(List<Product> productState) {
    this.productState = productState;
    notifyListeners();
  }
}
