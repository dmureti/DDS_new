class CustomerTransaction {
  String entryDate;
  String description;
  String documentType;
  String documentId;
  double debitAmount;
  double creditAmount;
  double balanceAmount;
  String comments;

  CustomerTransaction(
      {this.entryDate,
      this.description,
      this.documentType,
      this.documentId,
      this.debitAmount,
      this.creditAmount,
      this.balanceAmount,
      this.comments});

  factory CustomerTransaction.fromMap(Map<String, dynamic> data) {
    if (data == null)
      return null;
    else {
      return CustomerTransaction(
          entryDate: data['entryDate'],
          description: data['description'],
          documentType: data['documentType'],
          documentId: data['documentId'],
          debitAmount: data['debitAmount'],
          creditAmount: data['creditAmount'],
          balanceAmount: data['balanceAmount'],
          comments: data['comments']);
    }
  }
}
