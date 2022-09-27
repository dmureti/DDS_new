import 'dart:convert';

import 'package:distributor/app/locator.dart';

import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class PartialDeliveryViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  JourneyService _journeyService = locator<JourneyService>();
  UserService _userService = locator<UserService>();
  String get token => _userService.user.token;

  final _locationService = locator<LocationRepository>();

  SalesOrder _salesOrder;
  final DeliveryJourney deliveryJourney;
  String get stopId => deliveryStop.stopId;
  final DeliveryNote deliveryNote;
  SalesOrder get salesOrder => _salesOrder;

  PartialDeliveryViewModel(SalesOrder salesOrder, this.deliveryJourney,
      this.deliveryNote, this._deliveryStop) {
    _salesOrder = salesOrder;
    _newRequest = deliveryNote.deliveryItems
        .map((e) => SalesOrderRequestItem.fromMap(e))
        .toList();
  }

  UserLocation _userLocation;
  UserLocation get userLocation => _userLocation;

  getUserLocation() async {
    var result = await _locationService.getLocation();
    if (result is UserLocation) {
      _userLocation = result;
      notifyListeners();
    }
  }

  init() async {
    await getUserLocation();
  }

  final DeliveryStop _deliveryStop;
  DeliveryStop get deliveryStop => _deliveryStop;

  updateSalesOrderRequestItem(int index, String val) {
    _newRequest[index].quantity = int.parse(val);
    notifyListeners();
  }

  List<SalesOrderRequestItem> _newRequest;
  List<SalesOrderRequestItem> get newRequest => _newRequest;

  int _quantityToDeliver;
  int get quantityToDeliver => _quantityToDeliver;

  String _remarks = "";
  String get remarks => _remarks;

  makePartialDelivery() async {
    setBusy(true);

    Map<String, dynamic> data = {
      "atStopId": stopId,
      "deliveryDateTime": DateTime.now().toUtc().toIso8601String(),
      "deliveryLocation":
          "lat:${userLocation.latitude.toString()},lng:${userLocation.longitude.toString()}",
      "deliveryWarehouse": deliveryJourney.route,
      "items": newRequest.map((SalesOrderRequestItem e) {
        return {
          "item": {
            "id": e.itemCode,
            "itemCode": e.itemCode,
            "itemName": e.itemName,
            "itemPrice": e.itemRate,
          },
          "quantity": e.quantity
        };
      }).toList(),
      "onJourneyId": deliveryJourney.journeyId,
      "remarks": remarks,
      "salesOrderId": deliveryStop.orderId
    };
    print(json.encode(data));
    var result = await _journeyService.makePartialDelivery(
        journeyId: deliveryJourney.journeyId, data: data);
    setBusy(false);
    print(result);
    _navigationService.back(result: result);
    // if (result is CustomException) {
    //   await _dialogService.showDialog(
    //       title: result.title, description: result.description);
    // } else {
    //   _snackbarService.showSnackbar(
    //       message: 'The delivery was completed successfully');
    //   _navigationService.back(result: true);
    // }
  }
}
