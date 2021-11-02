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

// {
// referenceNo: SIAS-21-00001,
// baseType: Cash Invoice,
// customerId: Eric Mwangi Njuguna,
// transactionDate: 2021-11-03 02:22:16, total: 67.5, transactionStatus: Unpaid, saleItems: []
class AdhocSale {
  String referenceNo;
  String baseType;
  String transactionWarehouse;
  String customerId;
  String transactionDate;
  String customerName;
  num total;
  String transactionStatus;
  String sellingPriceList;
  List saleItems;

  AdhocSale(
      {this.referenceNo,
      this.baseType,
      this.transactionWarehouse,
      this.transactionDate,
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
      customerName: data['customerName'] ?? data['customerName'],
      transactionDate: data['transactionDate'],
      total: data['total'],
      transactionWarehouse: data['transactionWarehouse'],
    );
  }
}

// {"referenceNo":"PK-21-03161",
// "baseType":"Pickup",
// "transactionWarehouse":"Likoni",
// "customerId":"Moi Forces Academy Likoni",
// "customerName":"Moi Forces Academy Likoni",
// "transactionDate":"2021-11-03 00:44:46",
// "total":135.0,
// "transactionStatus":"To Bill",
// "sellingPriceList":"BICYCLE VENDORS -45",
// "saleItems":[{"erpId":"8ca79f04aa","parentId":"PK-21-03161","itemCode":"FG003","itemName":"200g White Bread","unitOfMeasure":"Nos","index":1,"quantity":6,"itemRate":22.5,"lineAmount":135.0,"warehouseId":"Likoni:Minishop Likoni"}]}
class AdhocDetail {
  final String referenceNo;
  final String baseType;
  final String deliveryType;
  String customerId;
  String customerName;
  String transactionDate;
  String transactionWarehouse;
  num total;
  String transactionStatus;
  String sellingPriceList;
  List saleItems;

  AdhocDetail(
      {this.referenceNo,
      this.customerId,
      this.transactionWarehouse,
      this.baseType,
      this.deliveryType,
      this.customerName,
      this.transactionDate,
      this.total,
      this.transactionStatus,
      this.sellingPriceList,
      this.saleItems});

  factory AdhocDetail.fromResponse(Map<String, dynamic> data) {
    return AdhocDetail(
      baseType: data['baseType'],
      referenceNo: data['referenceNo'],
      transactionWarehouse: data['transactionWarehouse'],
      deliveryType: data['deliveryType'],
      customerName: data['customerName'],
      transactionDate: data['transactionDate'],
      customerId: data['customerId'],
      total: data['total'],
      transactionStatus: data['transactionStatus'],
      sellingPriceList: data['sellingPriceList'],
      saleItems: data['saleItems'],
    );
  }
}

// {"message":"Success","payload":{"referenceNo":"PK-21-02789","baseType":"Pickup","transactionWarehouse":"Likoni:Minishop Likoni","customerId":"Bernard Kyalo Mwongela","customerName":"Bernard Kyalo Mwongela","transactionDate":"2021-10-24 06:02:25","total":9450.0,"transactionStatus":"Completed","sellingPriceList":"BICYCLE VENDORS -45","saleItems":[{"erpId":"3da287074a","parentId":"PK-21-02789","itemCode":"FG004","itemName":"400g Brown Bread","unitOfMeasure":"Nos","index":1,"quantity":4,"itemRate":45.0,"lineAmount":180.0,"warehouseId":"Likoni:Minishop Likoni"},{"erpId":"9b017ffe08","parentId":"PK-21-02789","itemCode":"FG014","itemName":"Butter Toast 400g","unitOfMeasure":"Nos","index":2,"quantity":25,"itemRate":45.0,"lineAmount":1125.0,"warehouseId":"Likoni:Minishop Likoni"},{"erpId":"239f51830c","parentId":"PK-21-02789","itemCode":"FG005","itemName":"400g White Bread","unitOfMeasure":"Nos","index":3,"quantity":110,"itemRate":45.0,"lineAmount":4950.0,"warehouseId":"Likoni:Minishop Likoni"},{"erpId":"65998c0f6a",

// "customerId": "string",
// "customerName": "string",
// "deliveryLocation": "string",
// "items": [
// {
// "itemCode": "string",
// "itemName": "string",
// "itemRate": 0,
// "quantity": 0
// }
// ],
// "payment": {
// "amount": 0,
// "externalAccountId": "string",
// "externalTxnID": "string",
// "externalTxnNarrative": "string",
// "payerAccount": "string",
// "payerName": "string",
// "paymentMode": "string",
// "userTxnNarrative": "string"
// },
// "remarks": "string",
// "sellingPriceList": "string",
// "warehouseId": "string"
class POSSaleRequest {
  String customerId;
  String customerName;
  String deliveryLocation;
  List items;
  Map<String, dynamic> payment;
  String remarks;
  String sellingPriceList;
  String warehouseId;

  POSSaleRequest(
      {this.customerName,
      this.customerId,
      this.deliveryLocation,
      this.items,
      this.payment,
      this.remarks,
      this.sellingPriceList,
      this.warehouseId});

  factory POSSaleRequest.fromMap() {
    return POSSaleRequest();
  }

  factory POSSaleRequest.fromSale(
      AdhocDetail adhocDetail, String customerId, String location) {
    return POSSaleRequest(
        customerName: adhocDetail.customerName,
        customerId: customerId,
        items: adhocDetail.saleItems,
        sellingPriceList: adhocDetail.sellingPriceList,
        deliveryLocation: location,
        warehouseId: adhocDetail.transactionWarehouse);
  }

  Map<String, dynamic> toJson() {
    return {
      "customerId": customerId,
      "customerName": customerName,
      "deliveryLocation": deliveryLocation,
      "items": items.map((e) => e).toList(),
      "payment": payment,
      "remarks": remarks,
      "sellingPriceList": sellingPriceList,
      "warehouseId": warehouseId
    };
  }
}
