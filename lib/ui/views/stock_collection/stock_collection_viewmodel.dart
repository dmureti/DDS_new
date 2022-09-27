import 'package:distributor/app/locator.dart';
import 'package:distributor/services/location_repository.dart';

import 'package:distributor/services/stock_controller_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StockCollectionViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _stockControlService = locator<StockControllerService>();
  final _locationService = locator<LocationRepository>();

  StockCollectionViewModel(this._deliveryStop);

  String _deliveryLocation;
  List _itemsToDeliver = [];

  List get itemsToDeliver => _itemsToDeliver;
  String get deliveryLocation => _deliveryLocation;

  _getCurrentLocation() async {
    var result = await _locationService.getLocation();
    if (result != null) {
      _deliveryLocation = "${result.latitude},${result.longitude}";
      notifyListeners();
    }
  }

  init() async {
    await _fetchGoodsToBeDelivered();
    await _getCurrentLocation();
  }

  _fetchGoodsToBeDelivered() async {
    setBusy(true);
    setBusy(false);
  }

  confirmCollection() async {
    var result = await _stockControlService.confirmStockCollection(
        stopId: deliveryStop.stopId,
        journeyId: deliveryStop.journeyId,
        deliveryLocation: deliveryLocation);
    if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    } else {
      await _dialogService.showDialog(
          title: 'Success', description: 'Stock confirmed successfully');
    }
  }

  final DeliveryStop _deliveryStop;
  DeliveryStop get deliveryStop => _deliveryStop;
}
