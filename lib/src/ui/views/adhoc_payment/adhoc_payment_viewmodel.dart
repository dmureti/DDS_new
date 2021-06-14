import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/adhoc_cart_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AdhocPaymentViewmodel extends ReactiveViewModel {
  AdhocCartService _adhocCartService = locator<AdhocCartService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_adhocCartService];

  List<String> get paymentModes => _adhocCartService.paymentModes;

  num get total => _adhocCartService.total;

  bool get isWalkinCustomer {
    if (customerType.toLowerCase() == 'contract') {
      return false;
    }
    return true;
  }

  String _paymentMode;
  String get paymentMode => _paymentMode;

  String get customerType => _adhocCartService.customerType;

  setPaymentType(String val) {
    _adhocCartService.setPaymentMode(val);
    _paymentMode = val;
    notifyListeners();
  }

  init() async {}

  String _remarks;
  String get remarks => _remarks;
  void updateRemarks(String value) {
    _remarks = value;
    notifyListeners();
  }

  completeAdhoc() async {
    setBusy(true);
    var result = await _adhocCartService.createPayment();
    setBusy(false);
    if (result is bool) {
      await _dialogService.showDialog(
          title: 'Success', description: 'The adhoc sale was successful');
      _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
    } else if (result is CustomException) {
      await _dialogService.showDialog(
          title: 'Error', description: result.description);
    }
  }

  bool get enableCheckout => paymentMode != null && paymentMode.isNotEmpty;
}
