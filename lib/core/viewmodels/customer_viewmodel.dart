import 'package:tripletriocore/tripletriocore.dart';

class CustomerViewmodel extends BaseModel {
  final Api _api;
  Api get api => _api;

  final User _user;
  User get user => _user;

  CustomerViewmodel({Api api, User user})
      : _api = api,
        _user = user;

  init() {
    fetchCustomers();
  }

  List<Customer> _customerList;
  List<Customer> get customerList => _customerList;

  Future<void> fetchCustomers() async {
    setBusy(true);
    _customerList = await _api.fetchAllCustomers(_user.token);
    setBusy(false);
  }

//  Future<List<Order>> fetchSalesOrderRequest() async {
//    var result = await _api.fetchOrderByCustomer(widget.user.token);
//    setState(() {
//      order = result;
//    });
//    return order;
//  }
}
