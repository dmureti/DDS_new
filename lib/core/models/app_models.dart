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

// {deliveryNoteId: PK-21-03141,
// deliveryType: Pickup,
// isReturn: 0,
// deliveryWarehouse: Likoni:Minishop Likoni,
// customerName: Abdull Lucky Karisa,
// deliveryDate: 2021-11-02,
// total: 90.0,
// deliveryStatus: To Bill,
// sellingPriceList: BICYCLE VENDORS -45,
// deliveryItems: [{dnItemId: 46d5fe67d7, deliveryNoteId: PK-21-03141, itemCode: FG004, itemName: 400g Brown Bread, unitOfMeasure: Nos, index: 1, quantity: 1, itemRate: 45.0, lineAmount: 45.0, warehouseId: Likoni:Minishop Likoni}, {dnItemId: a1b33e6517, deliveryNoteId: PK-21-03141, itemCode: FG005, itemName: 400g White Bread, unitOfMeasure: Nos, index: 2, quantity: 1, itemRate: 45.0, lineAmount: 45.0, warehouseId: Likoni:Minishop Likoni}]}
class AdhocDetail {
  final String deliveryNoteId;
  final String deliveryType;
  num isReturn;
  String deliveryWarehouse;
  String customerName;
  String deliveryDate;
  num total;
  String deliveryStatus;
  String sellingPriceList;
  List deliveryItems;

  AdhocDetail(
      {this.deliveryNoteId,
      this.deliveryType,
      this.isReturn,
      this.deliveryWarehouse,
      this.customerName,
      this.deliveryDate,
      this.total,
      this.deliveryStatus,
      this.sellingPriceList,
      this.deliveryItems});

  factory AdhocDetail.fromResponse(Map<String, dynamic> data) {
    return AdhocDetail(
        deliveryNoteId: data['deliveryNoteId'],
        deliveryType: data['deliveryType'],
        isReturn: data['isReturn'],
        deliveryWarehouse: data['deliveryWarehouse'],
        customerName: data['customerName'],
        deliveryDate: data['deliveryDate'],
        total: data['total'],
        deliveryStatus: data['deliveryStatus'],
        sellingPriceList: data['sellingPriceList'],
        deliveryItems: data['deliveryItems']);
  }
}
