import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';

import 'package:distributor/services/stock_controller_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StockCollectionViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _stockControlService = locator<StockControllerService>();

  List _itemsToDeliver = [];

  StockCollectionViewModel(this._deliveryStop);
  List get itemsToDeliver => _itemsToDeliver;

  init() async {
    await _fetchGoodsToBeDelivered();
  }

  _fetchGoodsToBeDelivered() async {
    setBusy(true);
    setBusy(false);
  }

  confirmCollection() async {
    var result = await _stockControlService.confirmStockCollection(
        stopId: deliveryStop.stopId, journeyId: deliveryStop.journeyId);
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
