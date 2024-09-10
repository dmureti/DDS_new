import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/src/ui/common/transaction_viewmodel.dart';
import 'package:distributor/traits/contextual_viewmodel.dart';

class StockTransactionViewmodel extends TransactionViewmodel
    with ContextualViewmodel {
  List<Transaction> _stockTransactionList;
  List<Transaction> get stockTransactionList => _stockTransactionList;

  getStockTransactions() async {
    setBusy(true);
    _stockTransactionList = await getAllStockTransactions();
    if (stockTransactionList.isNotEmpty) {
      _stockTransactionList
          .sort((b, a) => a.stockTransactionId.compareTo(b.stockTransactionId));
    }
    setBusy(false);
    notifyListeners();
  }
}
