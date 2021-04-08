import 'package:distributor/app/locator.dart';
import 'package:distributor/services/access_controller_service.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';

import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/core/enums.dart';

class CustomerService {
  AccessControlService _accessControlService = locator<AccessControlService>();
  ApiService _apiService = locator<ApiService>();
  UserService _userService = locator<UserService>();

  User get user => _userService.user;
  Api get api => _apiService.api;

  // List of customers
  List<Customer> _customerList;
  List<Customer> get customerList => _customerList;

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

  CustomerService() {
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
  }

  bool get enableCustomerTab => _accessControlService.enableCustomerTab;

  Future fetchOrdersByCustomer(String customerId) async {
    var result =
        await api.fetchOrderByCustomer(customerId, _userService.user.token);
    return result;
  }

  Future<CustomerAccount> getCustomerAccountTransactions(
      {String customerId}) async {
    var result = await api.getCustomerAccountTransactions(
        customerId: customerId, token: _userService.user.token);
    return result;
  }

  Future<Customer> getCustomerDetailById(String customerId) async {
    var result = await api.customerDetails(customerId, user.token);
    return result;
  }

  addPayment({
    PaymentModes paymentModes,
    Payment payment,
  }) async {
    String paymentMode = paymentModes.toString().split(".").last;
    Map<String, dynamic> data = payment.toJson();
    var result = await api.createPayment(data, user.token, paymentMode);
    return result;
  }

  listWarehouses() async {
    var result = await api.listWarehouses(user.token);
    print(result);
    return result;
  }
}
