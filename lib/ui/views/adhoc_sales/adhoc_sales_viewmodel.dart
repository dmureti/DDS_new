import 'package:distributor/app/locator.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AdhocSalesViewModel extends BaseViewModel {
  CustomerService _customerService = locator<CustomerService>();
  NavigationService _navigationService = locator<NavigationService>();

  navigateToPaymentView() async {}

  StockControllerService _stockControllerService =
      locator<StockControllerService>();
  JourneyService _journeyService = locator<JourneyService>();
  UserService _userService = locator<UserService>();
  List<String> customerTypes = ['Walk-in', 'Contract'];

  String _customerType;
  String get customerType => _customerType;

  int noOfSteps = 2;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;
  updateIsCompleted(bool val) {
    _isCompleted = val;
    notifyListeners();
  }

  updateCustomerType(String val) {
    _customerType = val;
    notifyListeners();
  }

  AdhocSalesViewModel(Customer customer) : _customer = customer;

  Customer _customer;
  Customer get customer => _customer;
  updateCustomer(Customer c) {
    _customer = c;
    notifyListeners();
  }

  void onStepTapped(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  void onStepCancel() {
    if (currentIndex != 0) {
      _currentIndex--;
    }
    notifyListeners();
  }

  void onStepContinue() {
    if (currentIndex != noOfSteps) {
      _currentIndex++;
    }
    notifyListeners();
  }

  String _customerName;
  String get customerName => _customerName;
  updateCustomerName(String val) {
    _customerName = val;
    notifyListeners();
  }

  List<Customer> _customerList;
  List<Customer> get customerList {
    print(deliveryJourney.route);
    if (_customerList.length > 0) {
      return _customerList
          .where((element) => element.route
              .toLowerCase()
              .contains(deliveryJourney.route.toLowerCase()))
          .toList()
            ..sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } else {
      // print(_customerList.first.route);
      return _customerList
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    }
  }

  DeliveryJourney get deliveryJourney => _journeyService.currentJourney;

  fetchCustomers() async {
    var result = await _customerService.customers;
    if (result is List<Customer>) {
      _customerList = result;
      notifyListeners();
    } else {
      _customerList = List<Customer>();
      notifyListeners();
    }
  }

  List<Product> _productList;
  List<Product> get productList => _productList;

  fetchStockBalance() async {
    var result = await _stockControllerService.getStockBalance();
    if (result is List<Product>) {
      _productList = result;
      notifyListeners();
    } else if (result is CustomException) {
      _productList = List<Product>();
      notifyListeners();
    }
  }
}
