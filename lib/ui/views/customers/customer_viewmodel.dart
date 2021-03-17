import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';

import 'package:distributor/services/customer_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CustomerViewModel extends FutureViewModel<List<Customer>> {
  CustomerService _customerService = locator<CustomerService>();
  NavigationService _navigationService = locator<NavigationService>();

  bool _isAsc = true;
  bool get isAsc => _isAsc;

  updateIsAsc() {
    _isAsc = !_isAsc;
    notifyListeners();
  }

  sortAsc() {
    if (_isAsc == true) {
      _customerList.sort((a, b) => a.name.compareTo(b.name));
      return _customerList;
    } else {
      _customerList.sort((a, b) => b.name.compareTo(a.name));
      return _customerList;
    }
  }

  List<Customer> _customerList;
  List<Customer> get customerList {
    if (_customerList != null) {
      if (_isAsc == true) {
        _customerList.sort((a, b) => a.name.compareTo(b.name));
        return _customerList;
      } else {
        _customerList.sort((a, b) => b.name.compareTo(a.name));
        return _customerList;
      }
    } else {
      return List<Customer>();
    }
  }

  List<Customer> get listOfCustomers {
    List<Customer> result = customerList;
    if (route == null) {
      return result;
    } else {
      route.forEach((key, value) {
        if (value == true) {
          result.removeWhere((customer) =>
              customer.route.toLowerCase().contains(key.toLowerCase()));
        }
        // } else {
        //   result.addAll(_customerList.where((customer) =>
        //       customer.route.toLowerCase().contains(key.toLowerCase())));
        // }
      });
      return result;
    }
  }

  Future<List<Customer>> fetchCustomers() async {
    var result = await _customerService.customers;
    return result;
  }

  List<String> _filters = List<String>();
  List<String> get filters => _filters ?? List<String>();

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

  void navigateToCustomer(Customer customer) async {
    await _navigationService.navigateTo(Routes.customerDetailView,
        arguments: CustomerDetailViewArguments(customer: customer));
  }

  @override
  void onData(List<Customer> data) {
    _customerList = data;
    data.forEach((customer) {
      _branches.add(customer.route);
      _route.putIfAbsent(customer.route, () => false);
    });
    super.onData(data);
  }

  @override
  Future<List<Customer>> futureToRun() => fetchCustomers();
}
