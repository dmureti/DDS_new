import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/product_service.dart';
import 'package:distributor/services/adhoc_cart_service.dart';

import 'package:distributor/services/order_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum ProductOrdering { alphaAsc, alphaDesc }

class SalesOrderViewModel extends ReactiveViewModel {
  AdhocCartService _adhocCartService = locator<AdhocCartService>();

  /// This is used to convert the local time to UTC.
  /// The [DatePicker] returns a date object with a default time of 00:00
  ///

  static const Duration kLocalTimeInUTC = Duration(hours: 4);
  ProductService _productService = locator<ProductService>();
  OrderService _orderService = locator<OrderService>();
  NavigationService _navigationService = locator<NavigationService>();
//  ApiService _apiService = locator<ApiService>();
//  UserService _userService = locator<UserService>();
//  Api get _api => _apiService.api;
//  User get _user => _userService.user;

  ProductOrdering _productOrdering = ProductOrdering.alphaAsc;

  navigateToCustomerDetailView() async {
    await _navigationService.popRepeated(1);
  }

  updateProductOrdering(ProductOrdering val) {
    _productOrdering = val;
    notifyListeners();
  }

  Customer _customer;
  Customer get customer => _customer;

  SalesOrderViewModel({@required Customer customer}) : _customer = customer;

  String _remarks = "";
  String get remarks => _remarks;
  updateRemarks(String val) {
    _remarks = val;
    notifyListeners();
  }

  List<Product> _productList;
  List<Product> get productList {
    switch (_productOrdering) {
      case ProductOrdering.alphaAsc:
        _productList.sort((a, b) => a.itemName.compareTo(b.itemName));
        break;
      case ProductOrdering.alphaDesc:
        _productList.sort((b, a) => a.itemName.compareTo(b.itemName));
        break;
    }
    return _productList;
  }

  int get availableProducts =>
      _productList.where((product) => product.itemPrice > 0).length;
  int get totalNoOfProducts => _productList.length;

  double _total = 0.00;
  double get total => _total;

  List<SalesOrderItem> _salesOrderItems = [];
  List<SalesOrderItem> get salesOrderItems => _salesOrderItems;

  List<Product> _items = [];
  List<Product> get items => _items;

  String _dueDate;
  String get dueDate => _dueDate;

  /// Added [Duration] 4 hours to the selected [DateTime]
  void setDueDate(DateTime dateTime) {
    _dueDate = dateTime.add(Duration(hours: 4)).toUtc().toIso8601String();
    notifyListeners();
  }

  /// It shall always start the following day
  //  DateTime _initialDate = DateTime.now().add(Duration(days: 1));
  DateTime _initialDate = DateTime.now();
  DateTime get initialDate => _initialDate;

  DateTime get firstDate => _initialDate;
  DateTime get lastDate => firstDate.add(Duration(days: 1));

  String formatDate(DateTime dateTime) {
    String result;
    var formatter = DateFormat('yyyy-MM-dd');
    result = formatter.format(dateTime);
    return result;
  }

  increaseSalesOrderItems(Product p, quantity) {
    _adhocCartService.increaseSalesOrderItems(p, quantity);
    if (_items.contains(p)) {
      // Get the element that contains the product in the sales item
      for (int i = 0; i < _salesOrderItems.length; i++) {
        if (_salesOrderItems[i].item == p) {
          // Increase the value of the sales order item
          _salesOrderItems[i].quantity += quantity;

          notifyListeners();
        }
      }
    } else {
      _items.add(p);
      SalesOrderItem s = SalesOrderItem(item: p, quantity: quantity);
      _salesOrderItems.add(s);
      notifyListeners();
    }
  }

  editQuantityManually(Product p, quantity) {
    if (_items.contains(p)) {
      for (int i = 0; i < _salesOrderItems.length; i++) {
        if (_salesOrderItems[i].item == p) {
          _salesOrderItems[i].quantity == quantity;
          if (quantity == 0) {
            items.remove(p);
            _salesOrderItems.removeAt(i);
          }
        }
      }
      notifyListeners();
    } else {
      //Add the item
      _items.add(p);
      salesOrderItems.add(SalesOrderItem(item: p, quantity: quantity));
      notifyListeners();
    }
  }

  decreaseSalesOrderItems(Product p, quantity) {
    _adhocCartService.decreaseSalesOrderItems(p, quantity);
    if (_items.contains(p)) {
      // Get the element that contains the product in the sales item
      for (int i = 0; i < _salesOrderItems.length; i++) {
        if (_salesOrderItems[i].item == p) {
          // Decrease the value of the sales order item
          _salesOrderItems[i].quantity -= quantity;
          if (salesOrderItems[i].quantity == 0) {
            _items.remove(p);
            _salesOrderItems.removeAt(i);
          }
        }
      }
    }
    notifyListeners();
  }

  addToTotal(double value) {
    _total += value;
    _adhocCartService.addToTotal(value);
    notifyListeners();
  }

  removeFromTotal(double value) {
    if (total > 0) {
      _total -= value;
      _adhocCartService.subtractFromTotal(value);
    }
    notifyListeners();
  }

  DialogService _dialogService = locator<DialogService>();

  Future fetchProducts() async {
    setBusy(true);
    var result = await _productService.fetchProductsByPriceList(customer);
    setBusy(false);
    if (result is List<Product>) {
      _productList = result;
      return _productList;
    } else {
      await _dialogService.showDialog(
          title: 'Error', description: 'An error occurred.');
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_adhocCartService];
}
