import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/services/user_service.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AccountsViewmodel extends FutureViewModel {
  final ApiService _apiService = locator<ApiService>();
  final UserService _userService = locator<UserService>();
  final CustomerService _customerService = locator<CustomerService>();

  Api get api => _apiService.api;
  String get token => _userService.user.token;

  bool get canViewAccounts => _customerService.enableAccountsTab;

  final Customer customer;

  AccountsViewmodel({@required this.customer}) : assert(customer != null);

  Future<CustomerAccount> fetchCustomerAccounts() async {
    return _customerService.getCustomerAccountTransactions(
        customerId: customer.id);
  }

  @override
  Future<CustomerAccount> futureToRun() async {
    if (canViewAccounts) {
      CustomerAccount result = await fetchCustomerAccounts();
      return result;
    } else {
      return null;
    }
  }
}
