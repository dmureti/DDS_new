class Price {
  String price;
  String pricePerMessage;

  Price({this.price, this.pricePerMessage});

  factory Price.fromMap(Map<String, dynamic> data) {
    return Price(
        price: data['price'] ?? "",
        pricePerMessage: data['pricePerMessage'] ?? "");
  }

  toJson() {
    return {"price": price, "pricePerMessage": pricePerMessage};
  }
}
