import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/services/adhoc_cart_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdhocDetailViewModel extends BaseViewModel {
  final String referenceNo;
  final _adhocService = locator<AdhocCartService>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  String get token => _userService.user.token;

  AdhocDetailViewModel(this.referenceNo, this.customerId, this.baseType);

  bool _fetched = false;
  bool get fetched => _fetched;

  AdhocDetail _adhocDetail;
  AdhocDetail get adhocDetail => _adhocDetail;

  getAdhocDetail() async {
    _adhocDetail =
        await _adhocService.fetchAdhocDetail(referenceNo, token, baseType);
    _fetched = true;
    notifyListeners();
  }

  confirmAction(String action) async {
    switch (action) {
      case 'cancel_adhoc_sale':
        var dialogResponse = await _dialogService.showConfirmationDialog(
            title: 'Cancel Transaction',
            description:
                'Are you sure you want to cancel this transaction ? You cannot undo this action.',
            cancelTitle: 'NO',
            confirmationTitle: 'Yes, I am sure');
        if (dialogResponse.confirmed) {
          await cancelTransaction();
        }
        break;
      case 'edit_adhoc_sale':
        editTransaction();
        break;
    }
  }

  //Flag to enable disable editable fields
  bool _inEditState = false;
  bool get inEditState => _inEditState;

  toggleEditState() {
    _inEditState = !inEditState;
    notifyListeners();
  }

  editTransaction() {
    toggleEditState();
  }

  cancelTransaction() async {
    bool result = await _adhocService.cancelAdhocSale(
        referenceNo, token, adhocDetail, baseType, customerId);
    if (result) {
      await _dialogService.showDialog(
          title: 'Success',
          description: 'The transaction was cancelled successfully.');
      _navigationService.back(result: true);
    }
    return;
  }

  reverseTransaction() async {
    bool result = await _adhocService.cancelAdhocSale(
        referenceNo, token, adhocDetail, baseType, customerId);
    if (result) {
      await _dialogService.showDialog(
          title: 'Success', description: 'The reversal was successful.');
      _navigationService.back(result: true);
    }
    return;
  }

  final String customerId;
  final String baseType;
}
