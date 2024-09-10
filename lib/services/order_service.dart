import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/services/firestore_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class OrderService with ReactiveServiceMixin {
  CustomerService _customerService = locator<CustomerService>();
  final _dataRepository = locator<FirestoreService>();
  OrderService() {
    listenToReactiveValues([
      _ordersPlaced,
      _salesOrderItems,
      _valueOfOrdersPlaced,
      _salesOrderList
    ]);
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
      RxValue<List<SalesOrderItem>>(initial: <SalesOrderItem>[]);
  List<SalesOrderItem> get salesOrderItems => _salesOrderItems.value;

  RxValue<List<SalesOrder>> _salesOrderList =
      RxValue<List<SalesOrder>>(initial: <SalesOrder>[]);
  List<SalesOrder> get salesOrderList => _salesOrderList.value;

  addToSalesOrderItemList() {}
  removeFromSalesOrderItemList() {}
  clearSalesOrderItemList() {}

  Future getSalesOrderItems(String salesOrderId) async {
    var result = await api.getSalesOrderRequestItems(salesOrderId, user.token);
    if (result is List<SalesOrderRequestItem>) {
      // _salesOrderItems.value = result;
    }
    return result;
  }

  Future createSalesOrder(
      SalesOrderRequest salesOrderRequest, Customer customer) async {
    var result = await api.createSalesOrder(
        user.token, salesOrderRequest, customer.customerCode,
        customerName: customer.name);
    if (result is bool) {
      /// Increase the count of sales orders
      _ordersPlaced.value++;
      updateValueOfOrdersPlaced(salesOrderRequest.total);

      var result = await _customerService
          .fetchCustomerOrdersNonReactive(customer.customerCode);
      if (result is CustomException) {
        print(result.description);
        print(result.title);
        print(result.code);
      }
      print("fetching customer orders");
      // await _dataRepository.placeOrder(
      //   {
      //     "customer": customer.customerCode,
      //     "event": "sales order",
      //     "source": "",
      //     "recipient": "",
      //     "title": "New Sales Order created",
      //     "body": ""
      //   },
      // );
      notifyListeners();
    }
    return result;
  }

  getSalesOrders(String customerId) async {}

  fetchOrdersByUser(String token) async {
    return await _apiService.api.getSalesOrdersByUser(token);
  }
}
