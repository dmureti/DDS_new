import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/src/ui/common/transaction_viewmodel.dart';
import 'package:stacked/stacked.dart';

class VoucherDetailViewmodel extends TransactionViewmodel {
  final String transactionId;
  final String voucherType;

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
  }

  bool _status = false;
  bool get status => _status;

  setStatusFromString(String val) {
    switch (val) {
      case 'Approve':
        return true;
      case 'Cancel':
        return false;
    }
  }

  setStatusFromBool(bool val) {
    switch (val) {
      case true:
        return 'Approve';
      case false:
        return 'Cancel';
    }
  }

  toggleStatus(bool val) {
    if (val) {
      _status = val;
      approveTransaction(stockTransaction);
    } else {
      _status = false;
      cancelTransaction(stockTransaction);
    }
    _status = val;
    getTransaction();
    notifyListeners();
  }
}
