class OrderItem {
  String soItemId;
  String orderId;
  String itemCode;
  String itemName;
  String unitOfMeasure;
  int index;
  int quantity;
  double itemRate;
  double lineAmount;

  OrderItem(
      {this.soItemId,
      this.orderId,
      this.itemCode,
      this.itemName,
      this.unitOfMeasure,
      this.index,
      this.quantity,
      this.itemRate,
      this.lineAmount});

  factory OrderItem.fromMap(var data) {
    return OrderItem(
        soItemId: data['soItemId'],
        orderId: data['orderItemId'],
        itemCode: data['itemCode'],
        itemName: data['itemName'],
        unitOfMeasure: data['unitOfMeasure'],
        index: data['index'],
        quantity: data['quantity'],
        itemRate: data['itemRate'],
        lineAmount: data['lineAmount']);
  }
}
