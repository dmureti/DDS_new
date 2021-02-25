class PaymentLink {
  String paymentMode;
  String transactionDate;
  String externalTransactionID;
  String internalTransactionID;
  String externalAccountID;
  String externalAccountName;
  List challengePayerAccount;
  List challengePayerName;
  List challengeAmount;

  PaymentLink(
      {this.paymentMode,
      this.transactionDate,
      this.externalTransactionID,
      this.internalTransactionID,
      this.externalAccountID,
      this.externalAccountName,
      this.challengePayerAccount,
      this.challengePayerName,
      this.challengeAmount});

  factory PaymentLink.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    } else {
      return PaymentLink(
          paymentMode: data['paymentMode'],
          transactionDate: data['transactionDate'],
          externalTransactionID: data['externalTransactionID'],
          internalTransactionID: data['internalTransactionID'],
          externalAccountID: data['externalAccountID'],
          externalAccountName: data['externalAccountName'],
          challengePayerAccount: data['challengePayerAccount'],
          challengePayerName: data['challengePayerName'],
          challengeAmount: data['challengeAmount']);
    }
  }
}
