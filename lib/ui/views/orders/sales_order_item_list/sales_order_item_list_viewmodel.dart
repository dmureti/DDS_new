import 'package:distributor/app/locator.dart';
import 'package:distributor/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class SalesOrderItemListViewModel
    extends FutureViewModel<List<SalesOrderRequestItem>> {
  final OrderService _orderService = locator<OrderService>();
  final DialogService _dialogService = locator<DialogService>();

  final String salesOrderId;
  SalesOrderItemListViewModel({@required this.salesOrderId})
      : assert(salesOrderId != null);

  Future<List<SalesOrderRequestItem>> fetchSalesOrderItems() async {
    return await _orderService.getSalesOrderItems(salesOrderId);
  }

  @override
  Future<List<SalesOrderRequestItem>> futureToRun() => fetchSalesOrderItems();

  @override
  void onError(error) async {
    await _dialogService.showDialog(
        title: 'Error', description: error.toString());
  }
}
