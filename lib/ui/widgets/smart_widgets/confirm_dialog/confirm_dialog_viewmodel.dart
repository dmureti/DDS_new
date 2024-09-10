import 'package:distributor/app/locator.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ConfirmDialogViewModel extends BaseViewModel {
  DialogService _dialogService = locator<DialogService>();
  JourneyService _journeyService = locator<JourneyService>();
  LogisticsService _logisticsService = locator<LogisticsService>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  final _locationService = locator<LocationRepository>();

  String _deliveryLocation;
  String get deliveryLocation => _deliveryLocation;

  getCurrentLocation() async {
    var result = await _locationService.getLocation();
    if (result != null) {
      _deliveryLocation = "${result.latitude},${result.longitude}";
      notifyListeners();
    }
  }

  final SalesOrder _salesOrder;
  SalesOrder get salesOrder => _salesOrder;

  ConfirmDialogViewModel({@required SalesOrder salesOrder})
      : _salesOrder = salesOrder,
        assert(salesOrder != null);

  bool _isChecked = false;
  bool get isChecked => _isChecked;

  void updateIsChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  completeTrip(String stopId) async {
    await getCurrentLocation();
    setBusy(true);
    var result = await _journeyService.makeFullSODelivery(
        salesOrder.orderNo, stopId, deliveryLocation);
    setBusy(false);
    if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
      return false;
    } else {
      _snackbarService.showSnackbar(
          message: "The action completed successfully.");
      return true;
    }
  }

  navigateToRoutes() async {
    _navigationService.popRepeated(2);
  }

  showFailedMessage() {
    _snackbarService.showSnackbar(
        title: 'Action failed', message: 'Could not stop the order');
  }
}
