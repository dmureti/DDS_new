import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/src/ui/common/transaction_viewmodel.dart';
import 'package:stacked/stacked.dart';

class VoucherDetailViewmodel extends TransactionViewmodel {
  final String transactionId;

  Transaction _stockTransaction;
  Transaction get stockTransaction => _stockTransaction;

  VoucherDetailViewmodel(this.transactionId);

  init() async {}

  bool _status;
  bool get status => _status;

  toggleStatus(bool val) {
    _status = val;
    notifyListeners();
  }
}
