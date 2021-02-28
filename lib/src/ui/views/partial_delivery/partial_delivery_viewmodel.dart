import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class PartialDeliveryViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  JourneyService _journeyService = locator<JourneyService>();
  DialogService _dialogService = locator<DialogService>();
  UserService _userService = locator<UserService>();
  String get token => _userService.user.token;

  SalesOrder _salesOrder;
  final DeliveryJourney deliveryJourney;
  final String stopId;

  SalesOrder get salesOrder => _salesOrder;

  List<SalesOrderRequestItem> get orderItems => salesOrder.orderItems;

  PartialDeliveryViewModel(
      SalesOrder salesOrder, this.deliveryJourney, this.stopId)
      : _salesOrder = salesOrder;

  updateSalesOrderRequestItem(int index, String val) {
    _salesOrder.orderItems[index].quantityDelivered = int.parse(val);
    notifyListeners();
  }

  String _remarks = "";
  String get remarks => _remarks;

  makePartialDelivery() async {
    setBusy(true);

    Map<String, dynamic> data = {
      "atStopId": stopId,
      "deliveryDateTime": DateTime.now().toUtc().toIso8601String(),
      "deliveryWarehouse": deliveryJourney.route,
      "items": orderItems.map((SalesOrderRequestItem e) {
        return {
          "item": {
            "id": e.soItemId,
            "itemCode": e.itemCode,
            "itemName": e.itemName,
            "itemPrice": e.itemRate,
          },
          "quantity": e.quantityDelivered
        };
      }).toList(),
      "onJourneyId": deliveryJourney.journeyId,
      "remarks": remarks,
      "salesOrderId": salesOrder.orderNo
    };
    var result = await _journeyService.makePartialDelivery(
        journeyId: deliveryJourney.journeyId, data: data);
    setBusy(false);
    if (result is CustomException) {
      return await _dialogService.showDialog(
          title: result.title, description: result.description);
    } else {
      // Notify the user that it was successful
      // Navigate back and clear the stack
    }
  }
}
