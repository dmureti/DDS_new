import 'package:distributor/src/ui/views/pos/base_pos_viewmodel.dart';

enum CustomerTypesDisplay { none, walkin, contract }

enum PaymentModeDisplay { none, mobile, cash, mixed }

class CheckOutViewModel extends BasePOSViewModel {
  final List<String> paymentMethods = ["Cash", "Mpesa", "Mixed"];

  String _customerType;
  PaymentModeDisplay _paymentModeDisplay = PaymentModeDisplay.none;
  CustomerTypesDisplay _customerTypesDisplay = CustomerTypesDisplay.none;

  PaymentModeDisplay get paymentModeDisplay => _paymentModeDisplay;
  CustomerTypesDisplay get customerTypesDisplay => _customerTypesDisplay;

  String get customerType => _customerType;

  get displayCustomers => _customerType.toLowerCase() == 'contract';

  String _paymentMode;
  String get paymentMode => _paymentMode;

  get isMixedPaymentMode =>
      _paymentMode?.toLowerCase() != 'cash' ||
      paymentMode?.toLowerCase() != 'mobile';

  double get total => 0;

  setCustomerType(String val) {
    _customerType = val;
    switch (val.toLowerCase()) {
      case 'contract':
        _customerTypesDisplay = CustomerTypesDisplay.contract;
        break;
      case 'walkin':
        _customerTypesDisplay = CustomerTypesDisplay.walkin;
        break;
      default:
        _customerTypesDisplay = CustomerTypesDisplay.none;
    }
    notifyListeners();
  }

  printReceipt() async {}

  //Set the payment method
  void setPaymentMode(String value) {
    _paymentMode = value;
    //Update the display
    switch (value.toLowerCase()) {
      case 'cash':
        _paymentModeDisplay = PaymentModeDisplay.cash;
        break;
      case 'mobile':
        _paymentModeDisplay = PaymentModeDisplay.mobile;
        break;
      case 'mixed':
        _paymentModeDisplay = PaymentModeDisplay.mixed;
        break;
      default:
        _customerTypesDisplay = CustomerTypesDisplay.none;
    }
    notifyListeners();
  }

  bool isConfirmedPayment = false;

  bool get isValidated => isConfirmedPayment;
  set isValidated(bool value) {
    isConfirmedPayment = value;
    notifyListeners();
  }

  void validateTransaction() {}

  String _customerName = "";
  String _phoneNumber = "";
  String _transactionCode = "";

  String get customerName => _customerName;
  String get phoneNumber => _phoneNumber;
  String get transactionCode => _transactionCode;

  setCustomerName(String val) {
    _customerName = val;
    notifyListeners();
  }

  setPhoneNumber(String val) {
    _phoneNumber = val;
    notifyListeners();
  }

  setTransactionCode(String val) {
    _transactionCode = val;
    notifyListeners();
  }

  initiatePushStk() {
    setBusy(true);
    setBusy(false);
  }

  validateTransactionCode(String val) {
    setBusy(true);
    notifyListeners();
    setBusy(false);
  }

  confirmPaymentReceipt(){
    notifyListeners();
  }
}
