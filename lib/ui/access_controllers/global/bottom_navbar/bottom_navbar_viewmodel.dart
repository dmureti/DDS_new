import 'package:distributor/services/customer_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:stacked/stacked.dart';

class BottomNavBarViewModel extends BaseViewModel {
  final Function onTap;
  int _index = 0;
  int get index => _index;

  updateIndex(int val) {
    _index = val;
    notifyListeners();
  }

  BottomNavBarViewModel(this.onTap, int index) : _index = index ?? 0;

  StockControllerService _stockControllerService = StockControllerService();
  CustomerService _customerService = CustomerService();
  JourneyService _journeyService = JourneyService();

  bool _enableCustomerTab = false;
  bool get enableCustomerTab => _enableCustomerTab;

  bool _enableJourneyTab = false;
  bool get enableJourneyTab => _enableJourneyTab;

  bool get enableHomeTab => true;

  bool _enableProductTab = false;
  bool get enableProductTab => _enableProductTab;

  //Initialize the permissions
  init() async {
    _enableCustomerTab = _customerService.enableCustomerTab;
    _enableProductTab = _stockControllerService.enableProductTab;
    _enableJourneyTab = _journeyService.enableJourneyTab;
    notifyListeners();
  }

  bool onStockBalanceTap() {
    if (_enableProductTab = false) {
      return false;
    } else {
      return true;
    }
  }

  onCustomerTabTap() {
    if (_enableCustomerTab = false) {
      return false;
    } else {
      return true;
    }
  }

  onJourneyTabTap() {
    if (_enableJourneyTab = false) {
      return false;
    } else {
      return true;
    }
  }
}
