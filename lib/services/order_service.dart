import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';

import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class OrderService with ReactiveServiceMixin {
  OrderService() {
    listenToReactiveValues(
        [_ordersPlaced, _salesOrderItems, _valueOfOrdersPlaced]);
  }
  ApiService _apiService = locator<ApiService>();
  UserService _userService = locator<UserService>();
  Api get api => _apiService.api;
  User get user => _userService.user;

  RxValue<int> _ordersPlaced = RxValue<int>(initial: 0);
  int get ordersPlaced => _ordersPlaced.value;

  RxValue<double> _valueOfOrdersPlaced = RxValue<double>(initial: 0.0);
  double get valueOfOrdersPlaced => _valueOfOrdersPlaced.value;

  updateValueOfOrdersPlaced(num val) {
    double parsedDouble = val.toDouble();
    _valueOfOrdersPlaced.value = _valueOfOrdersPlaced.value + parsedDouble;
  }

  RxValue<List<SalesOrderItem>> _salesOrderItems =
      RxValue<List<SalesOrderItem>>(initial: List<SalesOrderItem>());
  List<SalesOrderItem> get salesOrderItems => _salesOrderItems.value;

  addToSalesOrderItemList() {}
  removeFromSalesOrderItemList() {}
  clearSalesOrderItemList() {}

  Future getSalesOrderItems(String salesOrderId) async {
    var result = await api.getSalesOrderRequestItems(salesOrderId, user.token);
    return result;
  }

  Future createSalesOrder(SalesOrderRequest salesOrderRequest) async {
    var result = await api.createSalesOrder(user.token, salesOrderRequest);
    if (result is bool) {
      /// Increase the count of sales orders
      _ordersPlaced.value++;
      updateValueOfOrdersPlaced(salesOrderRequest.total);
    }
    return result;
  }
}
