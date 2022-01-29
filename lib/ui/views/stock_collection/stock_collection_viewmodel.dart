import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StockCollectionViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _stockControlService = locator<StockControllerService>();

  List _itemsToDeliver = [];
  List get itemsToDeliver => _itemsToDeliver;

  init() async {
    await _fetchGoodsToBeDelivered();
  }

  _fetchGoodsToBeDelivered() async {
    setBusy(true);
    setBusy(false);
  }

  confirmCollection() async {}
}
