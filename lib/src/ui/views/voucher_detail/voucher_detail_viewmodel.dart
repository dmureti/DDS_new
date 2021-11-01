import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/services/user_service.dart';
import 'package:distributor/src/ui/common/transaction_viewmodel.dart';

import 'package:stacked_services/stacked_services.dart';

class VoucherDetailViewmodel extends TransactionViewmodel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  final String transactionId;
  final String voucherType;

  List<String> statusStrings = ["Accept", "Cancel"];

  Transaction _stockTransaction;
  Transaction get stockTransaction => _stockTransaction;

  VoucherDetailViewmodel(this.transactionId, this.voucherType);

  init() async {
    await getTransaction();
  }

  //@TODO Check if this really works

  bool get originIsSelf {
    if (_userService.user.salesChannel.toLowerCase() !=
        _stockTransaction.sourceWarehouse.toLowerCase()) {
      return false;
    } else {
      return true;
    }
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
    var dialogResponse = await _dialogService.showConfirmationDialog(
        title: 'Change Status',
        description:
            'Are you sure you want to $val the status of this pending transaction?',
        cancelTitle: 'NO',
        confirmationTitle: 'Yes');
    if (dialogResponse.confirmed) {
      await commitStatusChange(val);
      _disableDropdown = true;
      await _dialogService.showDialog(
          title: 'Success',
          description: 'The transaction has been ${val}d successfully');
      getTransaction();
      _navigationService.back(result: true);
    } else {
      await _dialogService.showDialog(
          title: 'Status Not Changed',
          description: 'The status of the transaction has not changed.');
      _status = null;
    }
    notifyListeners();
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
