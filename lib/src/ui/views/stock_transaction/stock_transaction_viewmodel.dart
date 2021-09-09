import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/src/ui/common/transaction_viewmodel.dart';

class StockTransactionViewmodel extends TransactionViewmodel {
  navigateToVoucherDetailView(String transactionId) async {}

  List<Transaction> _stockTransactionList;
  List<Transaction> get stockTransactionList => _stockTransactionList;

  getStockTransactions() async {
    setBusy(true);
    _stockTransactionList = await getAllStockTransactions();
    setBusy(false);
  }
}
