import 'package:flutter/foundation.dart';
import 'package:tripletriocore/tripletriocore.dart';

class Invoice {
  final String id;
  final List items;
  final String deliveryStatus;
  CustomerDetail customerDetail;
  SellerDetail sellerDetail;
  String _transactionDate;
  // Type of transaction
  String transactionType;
  num total;

  String get customerName => customerDetail.customerName;
  String get sellerName => sellerDetail.sellerName;
  String get transactionDate => _transactionDate;

  Invoice(
      {@required this.items,
      @required this.id,
      this.deliveryStatus,
      CustomerDetail customerDetail,
      SellerDetail sellerDetail,
      String transactionDate})
      : _transactionDate = transactionDate ?? DateTime.now().toIso8601String();

  factory Invoice.fromMap(var data) {
    List items = data['items'];
    String id = data['id'];
    String deliveryStatus = data['deliveryStatus'];
    return Invoice(items: items, id: id);
  }

  factory Invoice.fromDeliveryNote() {
    return Invoice();
  }
}

class SellerDetail {
  String sellerName;
  String sellerId;
}

class CustomerDetail {
  String customerName;
  String customerId;
  String customerAddress;

  CustomerDetail({this.customerName, this.customerId, this.customerAddress});

  factory CustomerDetail.fromCustomer(Customer customer) {
    return CustomerDetail(
        customerName: customer.name,
        customerId: customer.id,
        customerAddress: customer.customerType);
  }
}
