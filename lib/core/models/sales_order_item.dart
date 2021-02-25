import 'product.dart';

class SalesOrderItem {
  Product item;
  int quantity;

  SalesOrderItem({this.item, this.quantity});

  SalesOrderItem.fromJson(Map parsedJson)
      : item = parsedJson['item'],
        quantity = parsedJson['quantity'];
}
