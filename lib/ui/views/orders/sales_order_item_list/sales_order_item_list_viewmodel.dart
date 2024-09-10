import 'package:distributor/app/locator.dart';
import 'package:distributor/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class SalesOrderItemListViewModel extends BaseViewModel {
  final OrderService _orderService = locator<OrderService>();
  final DialogService _dialogService = locator<DialogService>();

  final String salesOrderId;
  SalesOrderItemListViewModel({@required this.salesOrderId})
      : assert(salesOrderId != null);

  List<SalesOrderRequestItem> _salesOrderRequestItems = [];
  List<SalesOrderRequestItem> get salesOrderRequestItems =>
      _salesOrderRequestItems;

  init() async {
    await fetchSalesOrderItems();
  }

  fetchSalesOrderItems() async {
    setBusy(true);
    _salesOrderRequestItems =
        await _orderService.getSalesOrderItems(salesOrderId);
    setBusy(false);
    notifyListeners();
  }
}
