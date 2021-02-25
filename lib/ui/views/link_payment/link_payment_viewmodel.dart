import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/payment_link.dart';
import 'package:distributor/core/models/post_from_suspense.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class LinkPaymentViewmodel extends FutureViewModel {
  DialogService _dialogService = locator<DialogService>();
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();
  UserService _userService = locator<UserService>();

  User get user => _userService.user;

  bool _isComplete = false;
  bool get isComplete => _isComplete;

  int _index = 0;
  int get index => _index;

  final Customer _customer;
  Customer get customer => _customer;

  final PaymentLink _paymentLink;
  PaymentLink get paymentLink => _paymentLink;

  LinkPaymentViewmodel(Customer customer, PaymentLink paymentLink)
      : assert(customer != null),
        _customer = customer,
        _paymentLink = paymentLink;

  String _payerAccount;
  String get payerAccount => _payerAccount;

  String _payerName;
  get payerName => _payerName;

  String _amount;
  get amount => _amount;

  onStepTapped(value) {
    _index = value;
    notifyListeners();
  }

  onStepCancelled() {
    if (_index != 0) {
      _index--;
    }
    notifyListeners();
  }

  onStepContinue() {
    if (_index < 2) {
      _index++;
    } else {
      _isComplete = true;
    }
    notifyListeners();
  }

  postAnswers() {}

  Future fetchQuestions() async {}

  @override
  Future futureToRun() {
    var result = fetchQuestions();
    return result;
  }

  linkPayment() async {
    setBusy(true);
    PostFromSuspence postFromSuspence = PostFromSuspence(
        amount: amount,
        payerAccount: payerAccount,
        payerName: payerName,
        customerId: customer.id,
        externalTransactionId: paymentLink.externalTransactionID,
        paymentMode: paymentLink.paymentMode,
        transactionDate: paymentLink.transactionDate,
        internalTransactionId: paymentLink.internalTransactionID);
    var result = await _apiService.api
        .postFromSuspense(postFromSuspence.toJson(), user.token);
    setBusy(false);
    if (result is bool) {
      await _dialogService.showDialog(
          title: 'Success', description: "The payment was linked successfully");
      _navigationService.popRepeated(2);
    } else {
      await _dialogService.showDialog(
          title: 'Error linking payment', description: result);
    }
  }

  void updatePayerAccount(value) {
    _payerAccount = value;
    notifyListeners();
  }

  void updatePayerName(value) {
    _payerName = value;
    notifyListeners();
  }

  void updateAmount(value) {
    _amount = value;
    notifyListeners();
  }
}
