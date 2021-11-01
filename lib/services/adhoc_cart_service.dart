import 'dart:convert';

import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/user_service.dart';

import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

@lazySingleton
class AdhocCartService with ReactiveServiceMixin {
  ApiService _apiService = locator<ApiService>();
  UserService _userService = locator<UserService>();
  LogisticsService _logisticsService = locator<LogisticsService>();
  LocationService _locationService = locator<LocationService>();
  JourneyService _journeyService = locator<JourneyService>();

  UserLocation _userLocation;
  UserLocation get userLocation => _userLocation;

  getCurrentLocation() async {
    var result = await _locationService.getLocation();
    if (result is UserLocation) {
      _userLocation = result;
    }
  }

  List<String> _paymentModes;

  List<String> get paymentModes {
    List<String> _modes = [];
    if (customerType.toLowerCase() == 'contract') {
      if (showMPesa) {
        _modes.add('MPESA');
      }
      if (showAirtel) {
        _modes.add('EQUITEL');
      }
      _modes.addAll(
        ['CASH', 'INVOICE'],
      );
      return _modes;
    } else {
      if (showMPesa) {
        _modes.add('MPESA');
      }
      if (showAirtel) {
        _modes.add('EQUITEL');
      }
      _modes.add('CASH');
      return _modes;
    }
  }

  String get customerType => _customerType.value;

  RxValue<List<Product>> _itemsInCart = RxValue(initial: <Product>[]);
  List<Product> get itemsInCart => _itemsInCart.value;

  RxValue<List> _paymentModeDetails = RxValue(initial: []);
  List get paymentModeDetails => _paymentModeDetails.value;

  RxValue<bool> _showMPesa = RxValue(initial: false);
  RxValue<bool> _showEquitel = RxValue(initial: false);

  bool get showMPesa => _showMPesa.value;
  bool get showAirtel => _showEquitel.value;

  var _mpesaDetail;
  get mpesaDetail => _mpesaDetail;

  init() async {
    if (_logisticsService.currentJourney != null) {
      var mpesaRes =
          await getPOSAccount('MPESA', _journeyService.currentJourney.branch);
      if (mpesaRes is List) {
        if (mpesaRes.isNotEmpty) {
          _showMPesa.value = true;
          _mpesaDetail = mpesaRes;
        }
      }
      var airtelRes =
          await getPOSAccount('EQUITEL', _journeyService.currentJourney.branch);
      if (airtelRes is List) {
        if (airtelRes.isNotEmpty) {
          _showEquitel.value = true;
        }
      }
      // await getPaymentModes(_journeyService.currentJourney.route);
    }
    await getCurrentLocation();
  }

  getPOSAccount(String modeOfPayment, branchId) async {
    var result = await _apiService.api.getPOSAccount(
        modeOfPayment, _userService.user.token,
        branchId: branchId);
    return result;
  }

  getPaymentModes(String branchId) async {
    for (int i = 0; i < paymentModes.length; i++) {
      await getPOSAccount(paymentModes[i], branchId);
    }
  }

  Api get api => _apiService.api;
  String get token => _userService.user.token;

  RxValue _total = RxValue(initial: 0);
  RxValue _paymentMode = RxValue(initial: "");
  RxValue _customerId = RxValue(initial: null);
  RxValue _customerName = RxValue(initial: "");
  RxValue _sellingPriceList = RxValue(initial: "");
  RxValue<List<SalesOrderItem>> _items = RxValue(initial: <SalesOrderItem>[]);
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
      _showEquitel,
      _showMPesa,
      _warehouse,
      _customerType,
      _sellingPriceList
    ]);
    init();
  }

  num get total => _total.value;
  String get customerId => _customerId.value ?? null;
  String get warehouse => _warehouse.value;

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
          _items.value[i].quantity += quantity;
          notifyListeners();
        }
      }
    } else {
      _itemsInCart.value.add(p);
      SalesOrderItem s = SalesOrderItem(item: p, quantity: quantity);
      _items.value.add(s);
      notifyListeners();
    }
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
          _items.value[i].quantity -= quantity;

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
        "paymentMode": paymentMode == 'INVOICE LATER' ? 'ACCOUNT' : paymentMode,
        "userTxnNarrative": "string"
      },
      "deliveryLocation":
          "${userLocation?.latitude},${userLocation?.longitude}",
      "remarks": remarks,
      "sellingPriceList": sellingPriceList,
      "warehouseId":
          _journeyService.currentJourney.route ?? _userService.user.salesChannel
    };

    var result = await api.createPOSPayment(
        modeOfPayment: paymentMode == 'INVOICE' ? 'ACCOUNT' : paymentMode,
        data: data,
        token: token);
    if (result is bool) {
      resetTotal();
    }
    return result;
  }

  setWarehouse(String branch) {
    _warehouse.value = branch;
  }

  fetchAdhocSalesList() async {
    List result = await _apiService.api.getAdhocSales(_userService.user.token);
    print(result);
    if (result.isNotEmpty) {
      return result.map<AdhocSale>((e) => AdhocSale.fromResponse(e)).toList();
    }
    return <AdhocSale>[];
  }
}
