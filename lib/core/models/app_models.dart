import 'package:tripletriocore/tripletriocore.dart';

class Transaction {
  String stockTransactionId;
  String entryDate;
  String voucherType;
  String voucherSubType;
  String sourceWarehouse;
  String destinationWarehouse;
  String transactionStatus;
  List<Product> items;
  double value;

  Transaction(
      {this.stockTransactionId,
      this.entryDate,
      this.voucherType,
      this.voucherSubType,
      this.transactionStatus,
      this.items,
      this.value,
      this.destinationWarehouse,
      this.sourceWarehouse});

  factory Transaction.fromMap(Map<String, dynamic> parsedJson) {
    return Transaction(
        items: parsedJson['items']
            .map<Product>((e) => Product.fromJson(e))
            .toList(),
        transactionStatus: parsedJson['transactionStatus'],
        value: parsedJson['value'],
        destinationWarehouse: parsedJson['destinationWarehouse'],
        entryDate: parsedJson['entryDate'],
        sourceWarehouse: parsedJson['sourceWarehouse'],
        stockTransactionId: parsedJson['stockTransactionId'],
        voucherSubType: parsedJson['voucherSubType'],
        voucherType: parsedJson['voucherType']);
  }
}

class StockTransferRequest {
  // Channel
  String fromWarehouse;
  List<Product> items;
  // Branch
  String toWarehouse;

  StockTransferRequest({this.fromWarehouse, this.toWarehouse, this.items});

  Map<String, dynamic> toJson() => {
        "fromWarehouse": fromWarehouse,
        "items": items.map((e) => e.toJson()).toList(),
        "toWarehouse": toWarehouse
      };
}
