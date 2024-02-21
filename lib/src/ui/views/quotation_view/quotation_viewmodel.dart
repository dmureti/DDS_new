import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

import '../../../../app/locator.dart';
import '../../../../core/models/product_service.dart';

class QuotationViewModel extends BaseViewModel {
  final _productService = locator<ProductService>();

  List<Product> _productList = <Product>[];
  List<Product> get productList {
    return _productList.where((product) => product.itemPrice > 0).toList();
  }

  init() async {
    _items = await fetchItems();
    _itemsInCart = items;
    await fetchItems();
  }

  List _items = [];
  List get items => _items;
  List _itemsInCart = [];
  List get itemsInCart =>
      _itemsInCart.where((element) => element.quantity > 0).toList();

  updateQuantity({Product product, var newVal}) {
    var item = _itemsInCart.firstWhere(
        (element) =>
            element.itemName.toLowerCase() == product.itemName.toLowerCase(),
        orElse: () => product);
    item.updateQuantity(newVal);
    notifyListeners();
  }

  getQuantity(Product product) {
    var result = _itemsInCart.firstWhere(
        (element) =>
            element.itemName.toLowerCase() == product.itemName.toLowerCase(),
        orElse: () => null);
    return result?.quantity ?? 0;
  }

  getTotal(Product product) {
    var result = _itemsInCart.firstWhere(
        (element) =>
            element.itemName.toLowerCase() == product.itemName.toLowerCase(),
        orElse: () => null);
    return result?.quantity == null ? 0 : result.quantity * product.itemPrice;
  }

  fetchItems() async {
    setBusy(true);
    _productList = await _productService.listAllItems();
    //Initialize the stock transfer items with the value of product list
    _orderedItems = _productList;
    setBusy(false);
  }

  List<Product> _orderedItems = <Product>[];
  List<Product> get orderedItems =>
      _orderedItems.where((element) => element.quantity > 0).toList();

  placeQuotation() async {
    setBusy(true);
    setBusy(false);
  }
}
