import 'order_item.dart';

class SalesOrder {
  String orderNo;
  String branch;
  String customerName;
  String orderDate;
  String dueDate;
  double total;
  String orderStatus;
  List<OrderItem> orderItems;

  SalesOrder(
      {this.orderNo,
      this.branch,
      this.customerName,
      this.orderDate,
      this.dueDate,
      this.total,
      this.orderItems,
      this.orderStatus});

  factory SalesOrder.fromMap(Map<String, dynamic> data) {
    final orderItems = data['orderItems'];
    return SalesOrder(
        orderNo: data['orderNo'],
        branch: data['branch'],
        customerName: data['customerName'],
        orderDate: data['orderDate'],
        dueDate: data['dueDate'],
        total: data['total'],
        orderStatus: data['orderStatus'],
        orderItems:
            (orderItems as List).map((d) => OrderItem.fromMap(d)).toList());
  }
}
