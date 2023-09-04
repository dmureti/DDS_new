import 'package:distributor/app/locator.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:distributor/traits/contextual_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StockTransferRequestListingViewModel extends BaseViewModel
    with ContextualViewmodel {
  final _navigationService = locator<NavigationService>();
  final stockControlService = locator<StockControllerService>();

  List _stockTransferRequests = [];
  List get stockTransferRequests => _stockTransferRequests;

  init() async {
    await fetchStockTransferRequest();
  }

  fetchStockTransferRequest() async {
    setBusy(true);
    _stockTransferRequests =
        await stockControlService.getMiniShopStockRequests();
    if (_stockTransferRequests.isNotEmpty) {
      _stockTransferRequests
          .sort((b, a) => a.stockTransactionId.compareTo(b.stockTransactionId));
    }
    setBusy(false);
  }
}
