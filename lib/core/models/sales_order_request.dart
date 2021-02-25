import 'package:distributor/core/models/sales_order_item.dart';

class SalesOrderRequest {
  final String company;
  final String customer;
  String dueDate;
  String orderDate;
  final List<SalesOrderItem> items;
  final String orderType;
  final String sellingPriceList;
  final String warehouse;
  double total;

  SalesOrderRequest(
      {this.company,
      this.total,
      this.customer,
      this.dueDate,
      this.items,
      this.orderType,
      this.sellingPriceList,
      this.warehouse});

  SalesOrderRequest.fromJson(Map parsedJson)
      : company = parsedJson['company'] ?? '',
        customer = parsedJson['customer'] ?? '',
        dueDate = parsedJson['dueDate'] ?? '',
        items = parsedJson['items'] ?? [],
        orderType = parsedJson['orderType'] ?? '',
        sellingPriceList = parsedJson['defaultPriceList'] ?? '',
        warehouse = parsedJson['warehouse'] ?? '';
}
