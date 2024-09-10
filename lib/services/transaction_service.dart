import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class TransactionService with ReactiveServiceMixin {
  final journeyService = locator<JourneyService>();
  final stockControlService = locator<StockControllerService>();

  RxValue<List<Transaction>> _pendingTransactions =
      RxValue<List<Transaction>>(initial: <Transaction>[]);

  List<Transaction> get pendingTransactions => _pendingTransactions.value;

  bool get hasPendingTransactions => _pendingTransactions.value.isNotEmpty;

  int get numberOfPendingTransactions => _pendingTransactions.value.length;

  TransactionService() {
    listenToReactiveValues([_pendingTransactions]);
  }

  init() async {
    var result = await stockControlService.getTransactionsPendingAuth();
    _pendingTransactions.value = result;
  }
}
