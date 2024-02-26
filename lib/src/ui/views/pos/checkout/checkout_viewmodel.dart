import 'package:distributor/app/locator.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/src/ui/views/pos/base_pos_viewmodel.dart';
import 'package:tripletriocore/tripletriocore.dart';

enum CustomerTypesDisplay { none, walkin, contract }

enum PaymentModeDisplay { none, mobile, cash, mixed, cheque }

class CheckOutViewModel extends BasePOSViewModel {
  final _customerService = locator<CustomerService>();

  final List<String> paymentMethods = ["Cash", "Mpesa", "Mixed", "Cheque"];

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
      case 'cheque':
        _paymentModeDisplay = PaymentModeDisplay.cheque;
        break;
      default:
        _paymentModeDisplay = PaymentModeDisplay.none;
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

  confirmPaymentReceipt() {
    notifyListeners();
  }

  List<Customer> _customerList = <Customer>[];
  List<Customer> get customersList => _customerList;

  fetchCustomers() async {
    setBusy(true);
    _customerList = await _customerService.fetchCustomers();
    setBusy(false);
  }

  Customer _contractCustomer;
  Customer get contractCustomer => _contractCustomer;
  updateContractCustomer(Customer c) {
    _contractCustomer = c;
    notifyListeners();
  }

  init() async {
    await fetchCustomers();
  }
}
