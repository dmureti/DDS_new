import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:tripletriocore/tripletriocore.dart';

class OrderDetailViewModel extends ReactiveViewModel {
  LogisticsService _logisticsService = locator<LogisticsService>();
  JourneyService _journeyService = locator<JourneyService>();
  ApiService _apiService = locator<ApiService>();
  UserService _userService = locator<UserService>();
  User get user => _userService.user;
  Api get _api => _apiService.api;
  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  NavigationService _navigationService = locator<NavigationService>();

  Customer _customer;
  Customer get customer => _customer;

  init() async {
    await retrieveSalesOrder();
  }

  List<SalesOrderRequestItem> _salesOrderRequestItems =
      List<SalesOrderRequestItem>();
  List<SalesOrderRequestItem> get salesOrderRequestItems =>
      _salesOrderRequestItems;

  retrieveSalesOrder() async {
    setBusy(true);
    var result = await _api.journeyDetails(
        token: user.token, salesOrderId: salesOrderId);
    if (result is SalesOrder) {
      // result = SalesOrder(
      //     branch: 'ba',
      //     customerName: 'Kama',
      //     dueDate: DateTime.now().toUtc().toIso8601String(),
      //     orderDate: DateTime.now().toUtc().toIso8601String());
      // _salesOrder = result;
      setBusy(false);
      notifyListeners();
    }
    // List orderItems = result['orderItems'];
    // List<SalesOrderRequestItem> sot = orderItems.map((e) {
    //   SalesOrderRequestItem s = SalesOrderRequestItem.fromMap(e);
    //   return s;
    // }).toList();
    // _salesOrderRequestItems.addAll(sot);
  }

  final String salesOrderId;
  final String stopId;

  SalesOrder _salesOrder;
  SalesOrder get salesOrder => _salesOrder;

  DeliveryJourney _deliveryJourney;
  DeliveryJourney get deliveryJourney => _deliveryJourney;

  DeliveryJourney get currentJourney => _journeyService.currentJourney;

  bool get hasAuth {
    if (deliveryJourney != null) {
      return true;
    } else
      return false;
  }

  bool get canCloseOrder {
    if (currentJourney != null &&
        currentJourney.journeyId == deliveryJourney.journeyId &&
        currentJourney.status.toLowerCase() == 'in transit') {
      if (salesOrder.orderStatus.contains('To Deliver')) {
        return true;
      }
    }
    return false;
  }

  OrderDetailViewModel(
      {SalesOrder salesOrder,
      @required DeliveryJourney deliveryJourney,
      @required this.stopId})
      : _deliveryJourney = deliveryJourney,
        salesOrderId = salesOrder.orderNo,
        _salesOrder = salesOrder;

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_logisticsService, _journeyService];

  bool _showPartial = false;
  bool get showPartial => _showPartial;
  toggleShowPartial() {
    _showPartial = !showPartial;
    notifyListeners();
  }

  handleOrderAction(String action) async {
    switch (action) {
      case 'full_delivery':
        if (stopId != null) {}
        DialogResponse response = await _dialogService.showConfirmationDialog(
            description:
                'You are about to close the Sales Order ${salesOrder.orderNo} for ${salesOrder.customerName}.',
            title: 'COMPLETE ORDER',
            confirmationTitle: 'CONFIRM',
            cancelTitle: 'CANCEL');
        if (response.confirmed) {
          setBusy(true);
          var result = await _journeyService.makeFullSODelivery(
              salesOrder.orderNo, stopId);
          setBusy(false);
          if (result is CustomException) {
            // print(result.description);
            await _dialogService.showDialog(
                title: result.title, description: result.description);
          } else {
            _snackbarService.showSnackbar(
                message: 'The delivery was closed successfully');
          }
        }
        break;
      case 'partial_delivery':
        break;
      case 'add_payment':
        var result = await _navigationService.navigateTo(Routes.addPaymentView,
            arguments: AddPaymentViewArguments(customer: customer));
        if (result) {
          _snackbarService.showSnackbar(
              message: 'The payment was added successfully.');
        }
        break;
      case 'not_possible':
        await _dialogService.showDialog(
            title: 'Not possible',
            description: 'You cannot perform this action.');
        break;
    }
  }
}
