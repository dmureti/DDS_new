import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/core/enums.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class AddPaymentViewModel extends BaseViewModel {
  final Customer customer;
  CustomerService _customerService = locator<CustomerService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  AddPaymentViewModel(this.customer);

  List<PaymentModes> _paymentModes = [
    PaymentModes.MPESA,
    PaymentModes.Equitel,
    PaymentModes.Cash,
  ];

  List get paymentModes => _paymentModes;

  DateTime _lastDate = DateTime.now();
  DateTime get lastDate => _lastDate;

  DateTime _firstDate = DateTime.now().subtract(Duration(days: 7));
  DateTime get firstDate => _firstDate;

  DateTime _initialDate = DateTime.now();
  DateTime get initialDate => _initialDate;

  DateTime _transactionDate = DateTime.now();
  DateTime get transactionDate => _transactionDate;

  String _payerAccount;
  String get payerAccount => _payerAccount;

  String _payerName;
  String get payerName => _payerName;

  String _userTrxNarrative = "";
  String get userTrxNarrative => _userTrxNarrative;

  InvoiceAllocation _invoiceAllocation =
      InvoiceAllocation(invoiceId: "123", amount: 40);
  InvoiceAllocation get invoiceAllocation =>
      _invoiceAllocation ?? InvoiceAllocation(invoiceId: "123", amount: 40);
  updateUserTrxNarrative(String val) {
    _userTrxNarrative = val;
    notifyListeners();
  }

  updatePayerName(String val) {
    _payerName = val;
    notifyListeners();
  }

  updatePayerAccount(String val) {
    _payerAccount = val.trim();
    notifyListeners();
  }

  updateTransactionDate(DateTime dt) {
    _transactionDate = dt;
    notifyListeners();
  }

  List<String> walkInCustomerPaymentOption = ['MPESA', 'Equitel', 'Cash'];

  List<String> contractCustomerPaymentOptions = [
    'MPESA',
    'Equitel',
    'Cash',
    'Invoice'
  ];

  num _amount;
  num get amount => _amount;
  updateAmount(String val) {
    _amount = int.parse(val);
    notifyListeners();
  }

  //This is the till number
  String _externalAccountId;
  String get externalAccountId => _externalAccountId;
  updateExternalAccountId(String val) {
    print(val);
    _externalAccountId = val;
    notifyListeners();
  }

  String _externalTxnID;
  String get externalTxnID => _externalTxnID;
  updateExternalTxnID(String val) {
    print(val);
    _externalTxnID = val;
    notifyListeners();
  }

  String _externalTxnNarrative;
  String get externalTxnNarrative => _externalTxnNarrative;
  updateExternalTxnNarrative(String val) {
    _externalTxnNarrative = val;
    notifyListeners();
  }

  void submit() async {
    setBusy(true);
    String _paymentMode = paymentMode.toString().split(".").last;
    Payment payment = Payment(amount, customer.id,
        transactionDate.toUtc().toIso8601String(), _paymentMode,
        externalAccountId: externalAccountId,
        externalTxnID: externalTxnID,
        externalTxnNarrative: externalTxnNarrative,
        payerAccount: payerAccount ?? customer.telephone,
        payerName: payerName ?? customer.name,
        userTxnNarrative: userTrxNarrative,
        invoiceAllocation: invoiceAllocation);
    var result = await _customerService.addPayment(
        paymentModes: paymentMode, payment: payment, customerId: customer.id);
    setBusy(false);
    if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    } else {
      await _customerService.getCustomerAccountTransactions(
          customerId: customer.id);
      _navigationService.back(result: true);
    }
  }

  PaymentModes _paymentMode;
  PaymentModes get paymentMode => _paymentMode;
  void setPaymentMode(PaymentModes p) {
    _paymentMode = p;
    notifyListeners();
  }
}
