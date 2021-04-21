import 'dart:convert';

import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/order_service.dart';
import 'package:distributor/services/user_service.dart';

import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

@lazySingleton
class AdhocCartService with ReactiveServiceMixin {
  OrderService _orderService = locator<OrderService>();
  ApiService _apiService = locator<ApiService>();
  UserService _userService = locator<UserService>();
  LogisticsService _logisticsService = locator<LogisticsService>();

  List<String> get paymentModes => ['MPESA', 'Equitel', 'CASH'];

  RxValue<List<Product>> _itemsInCart = RxValue(initial: List<Product>());
  List<Product> get itemsInCart => _itemsInCart.value;

  RxValue<List> _paymentModeDetails = RxValue(initial: List());
  List get paymentModeDetails => _paymentModeDetails.value;

  init() async {
    if (_logisticsService.currentJourney != null) {
      await getPaymentModes(_logisticsService.currentJourney.branch);
    }
  }

  getPOSAccount(String modeOfPayment, branchId) async {
    var result = await _apiService.api.getPOSAccount(
      modeOfPayment,
      _userService.user.token,
    );
    print(result);
  }

  getPaymentModes(String branchId) async {
    for (int i = 0; i < paymentModes.length; i++) {
      getPOSAccount(paymentModes[i], branchId);
    }
  }

  Api get api => _apiService.api;
  String get token => _userService.user.token;

  RxValue _total = RxValue(initial: 0);
  RxValue _paymentMode = RxValue(initial: "");
  RxValue _customerId = RxValue(initial: null);
  RxValue _customerName = RxValue(initial: "");
  RxValue _sellingPriceList = RxValue(initial: "");
  RxValue<List<SalesOrderItem>> _items =
      RxValue(initial: List<SalesOrderItem>());
  RxValue _remarks = RxValue(initial: "");
  RxValue _customerType = RxValue(initial: "");
  RxValue _warehouse = RxValue(initial: "");

  AdhocCartService() {
    listenToReactiveValues([
      _total,
      _paymentMode,
      _customerId,
      _remarks,
      _customerName,
      _items,
      _itemsInCart,
      _warehouse,
      _customerType,
      _sellingPriceList
    ]);
    init();
  }

  num get total => _total.value;
  String get customerId => _customerId.value ?? null;
  String get warehouse => _warehouse.value;
  String get customerType => _customerType.value;
  List<SalesOrderItem> get items => _items.value;
  String get sellingPriceList => _sellingPriceList.value;
  String get paymentMode => _paymentMode.value;
  String get remarks => _remarks.value ?? "";

  setPaymentMode(String val) {
    _paymentMode.value = val;
  }

  increaseSalesOrderItems(Product p, quantity) {
    if (_itemsInCart.value.contains(p)) {
      // Get the element that contains the product in the sales item
      for (int i = 0; i < _items.value.length; i++) {
        if (_items.value[i].item == p) {
          // Increase the value of the sales order item
          _items.value[i].quantity++;
        }
      }
    } else {
      _itemsInCart.value.add(p);
      SalesOrderItem s = SalesOrderItem(item: p, quantity: quantity);
      _items.value.add(s);
    }
    notifyListeners();
  }

  resetTotal() {
    _total.value = 0;
    _itemsInCart.value.clear();
    _items.value.clear();
    notifyListeners();
  }

  decreaseSalesOrderItems(Product p, quantity) {
    if (_itemsInCart.value.contains(p)) {
      // Get the element that contains the product in the sales item
      for (int i = 0; i < _items.value.length; i++) {
        if (_items.value[i].item == p) {
          // Decrease the value of the sales order item
          _items.value[i].quantity--;

          if (items[i].quantity == 0) {
            _itemsInCart.value.remove(p);
            _items.value.removeAt(i);
          }
        }
      }
    }
    notifyListeners();
  }

  setCustomerType(String val) {
    _customerType.value = val;
  }

  setCustomerId(var val) {
    _customerId.value = val;
  }

  setCustomerName(String val) {
    _customerName.value = val;
  }

  setSellingPriceList(String val) {
    _sellingPriceList.value = val;
  }

  addToTotal(num val) {
    _total.value = _total.value + val;
  }

  setRemarks(String val) {
    _remarks.value = val;
  }

  subtractFromTotal(num val) {
    if (_total.value != 0) {
      _total.value = _total.value - val;
    }
  }

  get customerName => _customerName.value;

  createPayment() async {
    Map<String, dynamic> data = {
      "customerId": customerId,
      "customerName": customerName,
      "items": items
          .map((e) => {
                "itemCode": e.item.itemCode,
                "itemName": e.item.itemName,
                "itemRate": e.item.itemPrice,
                "quantity": e.quantity
              })
          .toList(),
      "payment": {
        "amount": total,
        "externalAccountId": "string",
        "externalTxnID": "string",
        "externalTxnNarrative": "string",
        "payerAccount": "string",
        "payerName": "string",
        "paymentMode": paymentMode,
        "userTxnNarrative": "string"
      },
      "remarks": remarks,
      "sellingPriceList": sellingPriceList,
      "warehouseId": warehouse
    };
    print(json.encode(data));
    var result = await api.createPOSPayment(
        modeOfPayment: paymentMode, data: data, token: token);
    if (result is bool) {
      resetTotal();
    }
    return result;
  }

  setWarehouse(String branch) {
    _warehouse.value = branch;
  }
}
