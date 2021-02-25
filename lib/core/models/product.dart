class Product {
  String description;
  final String id;
  final String itemName;
  final String itemCode;
  final double itemPrice;
//  final int lastPurchaseRate;
//  String name;
  final num quantity;

  Product(
      {this.id, this.itemCode, this.itemName, this.itemPrice, this.quantity});

  Product.fromJson(Map<String, dynamic> parsedjson)
      : itemCode = parsedjson['itemCode'],
        itemName = parsedjson['itemName'],
        description = parsedjson['description'],
        itemPrice = parsedjson['itemPrice'],
        quantity = parsedjson['quantity'] ?? 0,
        id = parsedjson['id'];

  Product.initial()
      : itemCode = "",
        id = "",
        itemName = "",
        itemPrice = 0.00,
        quantity = 0,
        description = "";
}
