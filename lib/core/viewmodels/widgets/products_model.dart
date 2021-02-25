import 'package:tripletriocore/tripletriocore.dart';
import 'package:flutter/widgets.dart';

class ProductsModel extends BaseModel {
  Api _api;

  ProductsModel({
    @required Api api,
  }) : _api = api;

  List<Product> products;

  Future fetchProducts(String token) async {
    setBusy(true);
    products = await _api.fetchAllProducts(token);
    setBusy(false);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
