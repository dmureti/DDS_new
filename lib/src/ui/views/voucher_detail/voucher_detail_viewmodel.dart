import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/src/ui/common/transaction_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VoucherDetailViewmodel extends TransactionViewmodel {
  final _dialogService = locator<DialogService>();
  final String transactionId;
  final String voucherType;

  List<String> statusStrings = ["Approve", "Cancel"];

  Transaction _stockTransaction;
  Transaction get stockTransaction => _stockTransaction;

  VoucherDetailViewmodel(this.transactionId, this.voucherType);

  init() async {
    await getTransaction();
  }

  getTransaction() async {
    setBusy(true);
    var result = await getStockTransaction(transactionId, voucherType);
    setBusy(false);
    if (result is Transaction) {
      _stockTransaction = result;
      notifyListeners();
    } else {}
    return;
  }

  String _status;
  String get status => _status;

  setStatus(String val) async {
    _status = val;
    await commitStatusChange(val);
    _disableDropdown = true;
    getTransaction();
    notifyListeners();
    await _dialogService.showDialog(
        title: 'Success',
        description: 'The transaction has been ${val}ed successfully');
  }

  bool _disableDropdown = false;
  bool get disableDropdown => _disableDropdown;

  commitStatusChange(String val) async {
    switch (status.toLowerCase()) {
      case 'accept':
        approveTransaction(stockTransaction);
        return;
        break;
      case 'cancel':
        cancelTransaction(stockTransaction);
        return;
        break;
    }
    return;
  }

  showConfirmationDialog() async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
        title: '$status transaction',
        description: 'Are you sure you want to $status this transaction ? ');
    return dialogResponse;
  }
}
