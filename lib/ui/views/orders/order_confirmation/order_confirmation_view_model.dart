import 'package:distributor/app/locator.dart';
import 'package:distributor/services/activity_service.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/services/order_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class OrderConfirmationViewModel extends ReactiveViewModel {
  OrderService _orderService = locator<OrderService>();
  CustomerService _customerService = locator<CustomerService>();
  ApiService _apiService = locator<ApiService>();
  UserService _userService = locator<UserService>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  ActivityService _activityService = locator<ActivityService>();

  Api get api => _apiService.api;

  User get user => _userService.user;
  final Customer customer;

  OrderConfirmationViewModel({@required this.customer})
      : assert(customer != null);

  navigateToProductSelection() async {
    _navigationService.popRepeated(1);
  }

  createSalesOrder(SalesOrderRequest salesOrder) async {
    setBusy(true);
    var result = await _orderService.createSalesOrder(salesOrder, customer);
    setBusy(false);
    if (result is bool) {
      if (result) {
        await _customerService.fetchOrdersByCustomer(customer.id);
        _activityService.addActivity(Activity(
            activityTitle: 'Sales Order submitted',
            activityDesc:
                'Sales Order for ${customer.name} of ${customer.route} created and submitted.'));
        _navigationService.back(result: true);
      }
    } else if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    }
  }

  calculateSalesOrderItemTotal() {}

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices =>
      [_customerService, _orderService];
}
