import 'package:distributor/app/locator.dart';
import 'package:distributor/services/access_controller_service.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';

import 'package:stacked/stacked.dart';

import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/core/enums.dart';
import 'package:observable_ish/observable_ish.dart';

class CustomerService with ReactiveServiceMixin {
  AccessControlService _accessControlService = locator<AccessControlService>();
  ApiService _apiService = locator<ApiService>();
  UserService _userService = locator<UserService>();

  User get user => _userService.user;
  Api get api => _apiService.api;

  // List of customers
  List<Customer> _customerList;
  List<Customer> get customerList => _customerList;

  RxValue<CustomerAccount> _customerAccount = RxValue<CustomerAccount>();
  RxValue<List<Issue>> _customerIssues =
      RxValue<List<Issue>>(initial: <Issue>[]);

  CustomerAccount get customerAccount => _customerAccount.value;

  List<Issue> get issueList => _customerIssues.value;

  getCustomerIssues(String customerId) async {
    var result = await _apiService.api
        .getCustomersIssuesByCustomer(customerId, user.token);
    if (result is List<Issue>) {
      _customerIssues.value = result;
      notifyListeners();
    }
  }

  Future<List<Customer>> get customers async {
    List<Customer> _customer =
        await _apiService.api.fetchAllCustomers(user.token);
    return _customer;
  }

  sortCustomerByName() async {
    List<Customer> customers =
        await _apiService.api.fetchAllCustomers(user.token);
    return customers.sort((a, b) => a.name.compareTo(b.name));
  }

  RxValue<List<SalesOrder>> _salesOrderList =
      RxValue<List<SalesOrder>>(initial: <SalesOrder>[]);
  List<SalesOrder> get salesOrderList => _salesOrderList.value;

  CustomerService() {
    listenToReactiveValues(
        [_salesOrderList, _customerIssues, _customerAccount]);
    init();
  }

  bool get enableAccountsTab {
    return _accessControlService.enableAccountsTab();
  }

  get enableIssuesTab {
    return _accessControlService.enableIssuesTab();
  }

  bool get enableInfoTab {
    return _accessControlService.enableInfoTab();
  }

  bool enablePlaceOrderButton() {
    bool result = false;
    if (_accessControlService.enablePlaceOrderButton) {
      result = true;
    }
    return result;
  }

  bool get enableOrdersTab => _accessControlService.enableOrdersTab;

  Future fetchCustomers() async {
    List<Customer> customer = await api.fetchAllCustomers(user.token);
    return customer;
  }

  init() {
    enableCustomerTab;
    enableAccountsTab;
    enablePlaceOrderButton;
    enableIssuesTab;
    //If accounts enabled
  }

  bool get enableCustomerTab => _accessControlService.enableCustomerTab;

  Future fetchOrdersByCustomer(String customerId) async {
    var result =
        await api.fetchOrderByCustomer(customerId, _userService.user.token);
    if (result is List<SalesOrder>) {
      _salesOrderList.value = result;
      notifyListeners();
    } else {
      _salesOrderList.value = <SalesOrder>[];
      notifyListeners();
    }
    return true;
  }

  addCustomerIssue(Issue issue, String customerId) async {
    var result = await _apiService.api
        .createIssue(issue.toJson(), _userService.user.token);
    if (result is bool) {
      await getCustomerIssues(customerId);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future getCustomerAccountTransactions({String customerId}) async {
    var result = await api.getCustomerAccountTransactions(
        customerId: customerId, token: _userService.user.token);
    if (result is CustomerAccount) {
      _customerAccount.value = result;
      notifyListeners();
    }
  }

  getCustomerDetailById(String customerId) async {
    var result = await api.customerDetails(customerId, user.token);
    return result;
  }

  addPayment(
      {PaymentModes paymentModes, Payment payment, String customerId}) async {
    String paymentMode = paymentModes.toString().split(".").last;
    Map<String, dynamic> data = payment.toJson();
    var result = await api.createPayment(data, user.token, paymentMode);
    if (result is bool) {
      await getCustomerAccountTransactions(customerId: customerId);
    }
    return result;
  }

  listWarehouses() async {
    var result = await api.listWarehouses(user.token);
    print(result);
    return result;
  }
}
