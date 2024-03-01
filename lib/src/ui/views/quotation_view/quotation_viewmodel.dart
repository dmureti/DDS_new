import 'package:distributor/services/customer_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

import '../../../../app/locator.dart';
import '../../../../core/models/product_service.dart';

enum CustomerTypesDisplay { none, walkin, contract }

class QuotationViewModel extends BaseViewModel {
  final _productService = locator<ProductService>();
  final _customerService = locator<CustomerService>();

  List<Product> _productList = <Product>[];
  List<Product> get productList {
    return _productList.where((product) => product.itemPrice > 0).toList();
  }

  List<Customer> _customerList = <Customer>[];
  List<Customer> get customersList => _customerList;

  fetchCustomers() async {
    setBusy(true);
    _customerList = await _customerService.fetchCustomers();
    setBusy(false);
  }

  CustomerTypesDisplay get customerTypesDisplay => _customerTypesDisplay;

  Customer _contractCustomer;
  Customer get contractCustomer => _contractCustomer;
  updateContractCustomer(Customer c) {
    _contractCustomer = c;
    notifyListeners();
  }

  String get customerType => _customerType;

  String _customerType;
  CustomerTypesDisplay _customerTypesDisplay = CustomerTypesDisplay.none;

  setCustomerType(String val) {
    _customerType = val;
    switch (val.toLowerCase()) {
      case 'contract':
        _customerTypesDisplay = CustomerTypesDisplay.contract;
        break;
      case 'walkin':
        _customerTypesDisplay = CustomerTypesDisplay.walkin;
        break;
      default:
        _customerTypesDisplay = CustomerTypesDisplay.none;
    }
    notifyListeners();
  }

  generateQuotation() async {
    setBusy(true);
    Map<String, dynamic> data = {
      "bill": "",
      "customer": contractCustomer.customerCode,
      "dueDate": DateTime.now().toUtc().toIso8601String(),
      "items": itemsInCart
          .map((e) => {
                "amount": "${e.itemPrice * e.quantity}",
                "item": {
                  "id": "${e.id}",
                  "itemCode": "${e.itemCode}",
                  "itemName": "${e.itemName}",
                  "itemPrice": "${e.itemPrice}",
                  "itemType": "product",
                  "priceList": "4SumPriceList"
                },
                "quantity": e.quantity,
                "rate": e.itemPrice,
                "tax": "16%",
              })
          .toList(),
      "orderType": "Sales Quotation",
      "warehouse": "Baba dogo"
    };
    await _productService.createNewQuotation(data);
    setBusy(false);
  }

  navigateToConfirmQuotationView() async {}

  init() async {
    _items = await fetchItems();
    await fetchCustomers();
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
    _items = _productList;
    _itemsInCart = _items;
    setBusy(false);
  }

  List<Product> _orderedItems = <Product>[];
  List<Product> get orderedItems =>
      _orderedItems.where((element) => element.quantity > 0).toList();
}
