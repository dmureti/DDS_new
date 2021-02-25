import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/models/payment_link.dart';

import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class PaymentReferenceViewmodel extends BaseViewModel {
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  UserService _userService = locator<UserService>();

  User get user => _userService.user;

  navigateToLinkPaymentView(PaymentLink paymentLink) async {
    _navigationService.navigateTo(
      Routes.linkPaymentView,
      arguments: LinkPaymentViewArguments(
          customer: _customer, paymentLink: paymentLink),
    );
  }

  final Customer _customer;

  PaymentReferenceViewmodel(Customer customer)
      : assert(customer != null),
        _customer = customer;

  List<String> paymentTypes = ["MPESA", "Cheque", "Debit/Credit"];

  String _paymentMode;
  String get paymentMode => _paymentMode ?? paymentTypes[0];

  updatePaymentMode(String val) {
    _paymentMode = val;
    notifyListeners();
  }

  String _paymentReference;
  String get paymentReference => _paymentReference;

  setPaymentReference(String val) {
    _paymentReference = val;
  }

  retrievePendingPayment() async {
    setBusy(true);
    var result = await _apiService.api.getFromSuspense(
        token: user.token,
        paymentMode: paymentMode,
        paymentReference: paymentReference.trim());
    setBusy(false);
    if (result is Map) {
      navigateToLinkPaymentView(PaymentLink.fromMap(result));
    } else {
      await _dialogService.showDialog(title: 'Error', description: result);
    }
  }
}
