import 'package:distributor/core/models/product.dart';
import 'package:distributor/core/models/sales_order_item.dart';

class SalesOrderRequest {
  final String orderNo;
  final String branch;
  final String company;
  final String customerName;
  final String orderDate;
  final String dueDate;
  final double total;
  final List<SalesOrderItem> items;
  final String orderType;
  final String sellingPriceList;
  final String warehouse;

  SalesOrderRequest(
      {this.company,
      this.branch,
      this.orderDate,
      this.total,
      this.orderNo,
      this.customerName,
      this.dueDate,
      this.items,
      this.orderType,
      this.sellingPriceList,
      this.warehouse});

  SalesOrderRequest.fromJson(Map parsedJson)
      : company = parsedJson['company'],
        orderDate = parsedJson['orderDate'],
        orderNo = parsedJson['orderNo'],
        total = parsedJson['total'],
        customerName = parsedJson['customerName'],
        branch = parsedJson['branch'],
        dueDate = parsedJson['dueDate'],
        items = parsedJson['items'],
        orderType = parsedJson['orderType'],
        sellingPriceList = parsedJson['sellingPriceList'],
        warehouse = parsedJson['warehouse'];
}

class SalesOrderRequestItem {
  final Product item;
  final int quantity;

  SalesOrderRequestItem({this.item, this.quantity});

  SalesOrderRequestItem.fromJson(Map parsedJson)
      : item = parsedJson['item'],
        quantity = parsedJson['quantity'];
}
