import 'package:flutter/cupertino.dart';

class PostFromSuspence {
  final dynamic amount;
  final String payerAccount;
  final String payerName;
  final String customerId;
  final String externalTransactionId;
  final String paymentMode;
  final dynamic transactionDate;

  final String internalTransactionId;

  PostFromSuspence(
      {@required this.amount,
      @required this.payerAccount,
      @required this.payerName,
      @required this.customerId,
      @required this.externalTransactionId,
      @required this.paymentMode,
      @required this.transactionDate,
      @required this.internalTransactionId});

  Map<String, dynamic> toJson() => {
        "amount": double.parse(amount),
        "payerAccount": payerAccount,
        "payerName": payerName,
        "customerId": customerId,
        "externalTransactionID": externalTransactionId,
        "internalTransactionID": internalTransactionId,
        "paymentMode": paymentMode,
        "transactionDate": transactionDate
      };
}
