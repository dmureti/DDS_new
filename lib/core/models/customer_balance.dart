class CustomerBalance {
  String description;
  double debitAmount;
  double creditAmount;
  double balanceAmount;

  CustomerBalance(
      {this.description,
      this.debitAmount,
      this.creditAmount,
      this.balanceAmount});

  factory CustomerBalance.fromMap(Map<String, dynamic> data) {
    if (data == null)
      return null;
    else {
      return CustomerBalance(
          description: data['description'],
          debitAmount: data['debitAmount'],
          creditAmount: data['creditAmount'],
          balanceAmount: data['balanceAmount']);
    }
  }
}
