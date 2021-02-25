class DeliveryStop {
  String address;
  String customerAddress;
  String customerId;
  int forCustomer;
  int index;
  String journeyId;
  String orderId;
  String stopId;
  int visited;

  DeliveryStop(
      {this.address,
      this.customerAddress,
      this.customerId,
      this.forCustomer,
      this.index,
      this.journeyId,
      this.orderId,
      this.stopId,
      this.visited});

  factory DeliveryStop.fromMap(Map data) {
    return DeliveryStop(
        address: data['address'],
        customerAddress: data['customerAddress'],
        customerId: data['customerId'],
        forCustomer: data['forCustomer'],
        index: data['index'],
        journeyId: data['journeyId'],
        orderId: data['orderId'],
        stopId: data['stopId'],
        visited: data['visited']);
  }

  toJson() {
    return {
      "address": address,
      "customerAddress": customerAddress,
      "customerId": customerId,
      "forCustomer": forCustomer,
      "index": index,
      "journeyId": journeyId,
      "orderId": orderId,
      "stopId": stopId,
      "visited": visited
    };
  }
}
