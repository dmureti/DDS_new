import 'package:tripletriocore/tripletriocore.dart';
import 'package:flutter/widgets.dart';

class OrdersModel extends BaseModel {
  Api _api;

  OrdersModel({
    @required Api api,
  }) : _api = api;

  List<Order> orders;

  Future fetchOrders(int postId) async {
    setBusy(true);
    orders = await _api.fetchAllOrders();
    setBusy(false);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
