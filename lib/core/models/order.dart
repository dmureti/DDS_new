class Order {
  final String orderNo;
  final String branch;
  final String orderStatus;
  String customerName;
  DateTime orderDate;
  String dueDate;
  double total;
  bool hasIssue;
  List<Map<String, dynamic>> particulars;

  Order(
      {this.customerName,
      this.orderNo,
      this.orderStatus,
      this.orderDate,
      this.dueDate,
      this.hasIssue,
      this.branch,
      this.particulars});

  factory Order.fromJson(Map parsedJson) {
    return Order(
        branch: parsedJson['branch'],
        customerName: parsedJson['customerName'],
        orderNo: parsedJson['orderNo'],
        orderDate: DateTime.parse(parsedJson['orderDate']),
        dueDate: parsedJson['dueDate'],
        hasIssue: parsedJson['hasIssue'],
        orderStatus: parsedJson['orderStatus'],
        particulars: parsedJson['particulars']);
  }
}
