import 'package:distributor/app/locator.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SalesReturnsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _stockControllerService = locator<StockControllerService>();

  List _salesReturns = [];
  List get salesReturns => _salesReturns;

  fetchSalesReturns() async {
    setBusy(true);
    _salesReturns = await _stockControllerService.getSalesReturns();
    setBusy(false);
    notifyListeners();
  }

  init() async {
    await fetchSalesReturns();
  }
}
