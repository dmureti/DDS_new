import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';

import '../../../services/journey_service.dart';

class TransactionViewmodel extends BaseViewModel {
  final stockControlService = locator<StockControllerService>();
  final journeyService = locator<JourneyService>();
  final userService = locator<UserService>();

  get branchId => !journeyService.hasJourney
      ? userService.user.salesChannel
      : journeyService.currentJourney.route;

  approveTransaction(Transaction t) async {
    return await stockControlService.updateStatus(t, 'Approve');
  }

  cancelTransaction(Transaction t) async {
    return await stockControlService.updateStatus(t, 'Cancel');
  }

  getStockTransaction(String stockTransactionId, String voucherType) async {
    return await stockControlService.getStockTransaction(
        stockTransactionId, voucherType);
  }

  getAllStockTransactions() async {
    return await stockControlService.getTransactionsPendingAuth();
  }
}
