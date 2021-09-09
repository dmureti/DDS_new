import 'package:distributor/core/models/app_models.dart';
import 'package:stacked/stacked.dart';

class TransactionViewmodel extends BaseViewModel {
  approveTransaction() async {}
  cancelTransaction() async {}

  getStockTransaction(String transactionId) async {}

  getAllStockTransactions() async {
    return <Transaction>[];
  }
}
