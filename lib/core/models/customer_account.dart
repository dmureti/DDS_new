import 'package:distributor/core/models/customer_balance.dart';
import 'package:distributor/core/models/customer_transaction.dart';

class CustomerAccount {
  CustomerBalance openingBalance;
  List<CustomerTransaction> transactions;
  CustomerBalance closingBalance;

  CustomerAccount(
      {this.openingBalance, this.transactions, this.closingBalance});

  factory CustomerAccount.fromMap(List data) {
    if (data == null)
      return null;
    else {
//      print(data);
      CustomerBalance openingBalance = CustomerBalance.fromMap(data[0]);
      //Split the list
      List transactions = data.sublist(1, data.length - 1);
      List<CustomerTransaction> customerTransactions =
          List<CustomerTransaction>();
      transactions.map((e) {
//        print(e.toString());
        CustomerTransaction c = CustomerTransaction.fromMap(e);
        return customerTransactions.add(c);
      }).toList();
      CustomerBalance closingBalance = CustomerBalance.fromMap(data.last);
//      print(customerTransactions.length);
      return CustomerAccount(
          openingBalance: openingBalance,
          transactions: customerTransactions,
          closingBalance: closingBalance);
    }
  }
}
