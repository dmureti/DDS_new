// {"message":"Success",
// "payload":[{"stockTransactionId":"TR-21-00007","entryDate":"2021-09-07 09:07:08",
// "voucherType":"Stock",
// "voucherSubType":"TransferIn","sourceWarehouse":"Bamburi","destinationWarehouse":"Bombolulu","transactionStatus":"Pending","items":[],"value":248.85}],"recordCount":-1}
import 'package:tripletriocore/tripletriocore.dart';

class Transaction {
  String stockTransactionId;
  String entryDate;
  String voucherType;
  String voucherSubType;
  String sourceWarehouse;
  String destinationWarehouse;
  String transactionStatus;
  List<Map<String, int>> items;
  double value;

  Transaction();
}

class StockTransferRequest {
  // Channel
  String fromWarehouse;
  List<Map<Item, int>> items;
  // Branch
  String toWarehouse;

  StockTransferRequest({this.fromWarehouse, this.toWarehouse});

  Map<String, dynamic> toJson() => {
        "fromWarehouse": fromWarehouse,
        "items": items,
        "toWarehouse": toWarehouse
      };
}
