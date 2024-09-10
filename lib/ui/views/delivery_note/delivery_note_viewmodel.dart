import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class DeliveryNoteViewmodel extends BaseViewModel {
  ApiService _apiService = locator<ApiService>();
  UserService _userService = locator<UserService>();
  DialogService _dialogService = locator<DialogService>();

  final SalesOrder _salesOrder;
  String _customerName;
  String get customerName => _customerName;

  String get salesOrderId => _salesOrder.orderNo;

  init() async {
    await getDeliveryNotesForSalesOrder(salesOrderId);
  }

  DeliveryNoteViewmodel(SalesOrder salesOrder, {String customerName})
      : _customerName = salesOrder.customerName,
        _salesOrder = salesOrder;

  Api get api => _apiService.api;
  User get user => _userService.user;

  List<DeliveryNote> _deliveryNotes = <DeliveryNote>[];
  List<DeliveryNote> get deliveryNotes => _deliveryNotes;

  getDeliveryNotesForCustomer() async {
    setBusy(true);
    var result = await api.getDeliveryNotesForCustomer(
        token: user.token, customerId: _salesOrder.customerName);
    setBusy(false);
    if (result is String) {
      await _dialogService.showDialog(title: 'Error', description: result);
    } else {
      _deliveryNotes = result;
      notifyListeners();
    }
    return result;
  }

  getDeliveryNotesForSalesOrder(String salesOrderId) async {
    setBusy(true);
    var result = await api.getDeliveryNotesForSO(
        salesOrderId: customerName, token: user.token);
    setBusy(false);
    if (result is String) {
      await _dialogService.showDialog(title: 'Error', description: result);
    } else {
      _deliveryNotes = result;
      notifyListeners();
    }
  }
}
