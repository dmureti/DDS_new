import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';

import 'package:distributor/services/customer_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CustomerViewModel extends FutureViewModel<List<Customer>> {
  CustomerService _customerService = locator<CustomerService>();
  NavigationService _navigationService = locator<NavigationService>();

  bool _isLargeScreen;
  set isLargeScreen(bool val) {
    _isLargeScreen = val;
  }

  bool get isLargeScreen => _isLargeScreen;

  bool _isAsc = true;
  bool get isAsc => _isAsc;

  updateIsAsc() {
    _isAsc = !_isAsc;
    notifyListeners();
  }

  bool _sortAscending = false;
  bool get sortAscending => _sortAscending;
  toggleSortAscending() {
    _sortAscending = !sortAscending;
    notifyListeners();
  }

  List<Customer> _unorderedList;
  List<Customer> get unorderedList => _unorderedList;
  List<Customer> _customerList;
  List<Customer> get customerList {
    if (_customerList != null) {
      //Check if the customer filters are set
      switch (customerFilter.toLowerCase()) {
        case 'all':
          _customerList = unorderedList;
          _customerList.sort(
              (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
          break;
        case 'name':
          if (sortAscending) {
            _customerList.sort((a, b) => a.name.compareTo(b.name));
          } else {
            _customerList.sort((a, b) => b.name.compareTo(a.name));
          }
          break;
        case 'route':
          if (sortAscending) {
            // _customerList.sort((a, b) => a.route.compareTo(b.route));
          } else {
            // _customerList.sort((a, b) => b.route.compareTo(a.route));
          }
          break;
        default:
          _customerList = unorderedList;
          _customerList
            ..sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
          break;
      }
      return _customerList;
    } else {
      return <Customer>[];
    }
  }

  List<Customer> get listOfCustomers {
    // List<Customer> result = customerList;
    // if (route == null) {
    //   return result;
    // } else {
    //   route.forEach((key, value) {
    //     if (value == true) {
    //       result.removeWhere((customer) =>
    //           customer.route.toLowerCase().contains(key.toLowerCase()));
    //     }
    //     // } else {
    //     //   result.addAll(_customerList.where((customer) =>
    //     //       customer.route.toLowerCase().contains(key.toLowerCase())));
    //     // }
    //   });
    //   return result;
    // }
    return customerList;
  }

  Future<List<Customer>> fetchCustomers() async {
    var result = await _customerService.customers;
    return result;
  }

  List<String> _filters = <String>[];
  List<String> get filters => _filters ?? <String>[];

  bool checkIfFilterExists(String val) {
    if (_filters.length == 0) {
      return false;
    } else {
      if (_filters.contains(val)) {
        return true;
      }
      return false;
    }
  }

  List<Map<String, dynamic>> customerFilters = [
    {"name": "All", "value": "All"},
    {"name": "Name", "value": "Sort By Name"},
    {"name": "Route", "value": "Sort By Route"},
  ];

  String _customerFilter = "All";
  String get customerFilter => _customerFilter;
  set customerFilter(String val) {
    _customerFilter = val;
    notifyListeners();
  }

  addToFilters(String value) {
    _route.update(value, (value) => true);
    // _filters.add(value);
    notifyListeners();
  }

  removeFromFilters(String val) {
    _route.update(val, (value) => false);
    // _filters.remove(val);
    notifyListeners();
  }

  updateFilters(bool val, String filter) {
    if (val == true) {
      addToFilters(filter);
    } else {
      removeFromFilters(filter);
    }
    notifyListeners();
  }

  Set<String> _branches = Set();

  List get branches {
    List branchList = _branches.toList();
    branchList.sort((a, b) => a.toString().compareTo(b.toString()));
    return branchList;
  }

  Map _route = {};
  Map get route => _route;

  Customer _customer;
  Customer get customer => _customer;
  set customer(var c) {
    _customer = c;
    notifyListeners();
  }

  void navigateToCustomer(Customer val) async {
    if (isLargeScreen) {
      customer = val;
      notifyListeners();
    } else {
      await _navigationService.navigateTo(Routes.customerDetailView,
          arguments: CustomerDetailViewArguments(customer: val));
    }
  }

  @override
  void onData(List<Customer> data) {
    _customerList = data;
    _unorderedList = _customerList;
    data.forEach((customer) {
      // _branches.add(customer.route);
      _route.putIfAbsent(customer.route, () => false);
    });
    super.onData(data);
  }

  @override
  Future<List<Customer>> futureToRun() => fetchCustomers();
}
