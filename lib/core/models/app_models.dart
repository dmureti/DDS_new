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

//[{
// referenceNo: PK-21-03138,
// baseType: Pickup,
// transactionWarehouse: Likoni:Minishop Likoni,
// customerId: Zacharia Maghanga Mwasaru,
// customerName: Zacharia Maghanga Mwasaru,
// total: 88.0,
// transactionStatus: To Bill,
// sellingPriceList: BICYCLE VENDORS -45,
// saleItems: []}
class AdhocSale {
  String referenceNo;
  String baseType;
  String transactionWarehouse;
  String customerId;
  String customerName;
  num total;
  String transactionStatus;
  String sellingPriceList;
  List saleItems;

  AdhocSale(
      {this.referenceNo,
      this.baseType,
      this.transactionWarehouse,
      this.customerId,
      this.customerName,
      this.total,
      this.transactionStatus,
      this.saleItems,
      this.sellingPriceList});

  factory AdhocSale.fromResponse(Map<String, dynamic> data) {
    return AdhocSale(
      referenceNo: data['referenceNo'],
      baseType: data['baseType'],
      transactionStatus: data['transactionStatus'],
      customerId: data['customerId'],
      customerName: data['customerName'],
      total: data['total'],
      transactionWarehouse: data['transactionWarehouse'],
    );
  }
}
