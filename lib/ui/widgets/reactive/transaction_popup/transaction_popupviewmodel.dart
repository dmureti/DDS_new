import 'package:distributor/app/locator.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/transaction_service.dart';
import 'package:stacked/stacked.dart';

class TransactionPopupViewModel extends ReactiveViewModel {
  final _transactionService = locator<TransactionService>();

  TransactionPopupViewModel(this.onSubmitted);

  bool get hasPendingTransactions =>
      _transactionService.pendingTransactions.isNotEmpty;
  int get numberOfPendingTransactions =>
      _transactionService.numberOfPendingTransactions;

  final Function onSubmitted;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_transactionService];

  onPopupAction(var value) async {
    await onSubmitted(value);
    await init();
    notifyListeners();
  }

  init() async {
    setBusy(true);
    await _transactionService.init();
    setBusy(false);
  }
}
