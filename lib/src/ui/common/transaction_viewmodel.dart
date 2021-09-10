import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:stacked/stacked.dart';

class TransactionViewmodel extends BaseViewModel {
  final stockControlService = locator<StockControllerService>();

  approveTransaction() async {}
  cancelTransaction() async {}

  getStockTransaction(String transactionId) async {}

  getAllStockTransactions() async {
    return await stockControlService.getTransactionsPendingAuth();
  }
}
