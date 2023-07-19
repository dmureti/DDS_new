import 'package:distributor/app/locator.dart';
import 'package:distributor/services/order_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CrewHistoryViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _orderService = locator<OrderService>();
  final _userService = locator<UserService>();

  String get token => _userService.user.token;

  List<SalesOrder> _orders = [];
  List<SalesOrder> get orders => _orders;

  init() async {
    fetchOrders();
  }

  //fetch all orders
  fetchOrders() async {
    setBusy(true);
    var result = await _orderService.fetchOrdersByUser(token);
    setBusy(false);
    if (result is List<SalesOrder>) {
      _orders = result;
    }
    notifyListeners();
  }

  navigateToSalesOrder(){

  }

  syncOrder(){
    
  }
}
