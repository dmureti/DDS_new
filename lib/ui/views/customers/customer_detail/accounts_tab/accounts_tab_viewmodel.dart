import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AccountsTabViewModel extends ReactiveViewModel {
  final ApiService _apiService = locator<ApiService>();
  final UserService _userService = locator<UserService>();
  final CustomerService _customerService = locator<CustomerService>();

  DateTime _calendarInitialDate = DateTime.now().subtract(Duration(days: 40));
  DateTime _calendarEndDate = DateTime.now().subtract(Duration(days: 40));
  DateTime _calendarFirstDate = DateTime.now();

  DateTime get calendarInitialDate => _calendarInitialDate;
  DateTime get calendarEndDate => _calendarEndDate;
  DateTime get calendarFirstDate => _calendarFirstDate;

  Api get api => _apiService.api;
  String get token => _userService.user.token;

  bool get canViewAccounts => _customerService.enableAccountsTab;

  DateTime _startDate = null;
  DateTime get startDate => _startDate;

  DateTime _lastDate = DateTime.now().add(Duration(days: 1));
  DateTime get lastDate => _lastDate;

  clear() {
    _startDate = DateTime.now().subtract(Duration(days: 40));
    _endDate = DateTime.now().add(Duration(days: 1));
    _isFiltered = false;
    _showDateSelection = false;
    notifyListeners();
  }

  updateStartDate(DateTime val) {
    _startDate = val;
    updateIsFiltered();
    notifyListeners();
  }

  bool _showDateSelection = false;
  bool get showDateSelection => _showDateSelection;
  updateShowDateSelection(bool val) {
    _showDateSelection = val;
    notifyListeners();
  }

  toggleShowDateSelection() {
    _showDateSelection = !showDateSelection;
    notifyListeners();
  }

  //The initial date when the records are first pulled
  DateTime _initialDate = DateTime.now();
  // The initial end date when the records are first pulled
  DateTime get initialDate => _initialDate;

  DateTime _initialEndDate = DateTime.now().add(Duration(days: 1));
  DateTime get initialEndDate => _initialEndDate;

  DateTime _firstDate = DateTime.now().subtract(Duration(days: 40));
  DateTime get firstDate => _firstDate;

  // The datetime used to filter records
  DateTime _endDate;
  DateTime get endDate => _endDate;

  updateEndDate(DateTime val) {
    _endDate = val;
    notifyListeners();
  }

  CustomerAccount get customerAccount => _customerService.customerAccount;

  List<CustomerTransaction> get customerTransactionList {
    if (_sortAscending == false) {
      customerAccount.transactions
          .sort((a, b) => ((b.entryDate.compareTo(a.entryDate))));
    } else {
      customerAccount.transactions
          .sort((a, b) => ((a.entryDate.compareTo(b.entryDate))));
    }
    return customerAccount.transactions;
  }

  final Customer customer;

  AccountsTabViewModel({@required this.customer}) : assert(customer != null);

  init() async {
    await fetchCustomerAccounts();
  }

  fetchCustomerAccounts() async {
    await _customerService.getCustomerAccountTransactions(
        customerId: customer.customerCode);
    notifyListeners();
    if (customerAccount != null) {
      _initialDate =
          DateTime.tryParse(customerAccount.transactions[0].entryDate);
      _startDate = DateTime.tryParse(customerAccount.transactions[0].entryDate);
      _endDate = DateTime.now();
      notifyListeners();
    }
  }

  bool _isFiltered = false;
  bool get isFiltered => _isFiltered;

  updateIsFiltered() {
    _isFiltered = !isFiltered;
    notifyListeners();
  }

  bool _sortAscending = false;
  bool get sortAscending => _sortAscending;

  void toggleSortByDate() {
    _sortAscending = !_sortAscending;
    notifyListeners();
  }

  void updateRange(DateTime result) {
//    _startDate = result.start.subtract(Duration(days: 1));
//    _endDate = result.end.add(Duration(days: 1));
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_customerService];
}
