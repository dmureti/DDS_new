import 'package:distributor/app/locator.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:stacked/stacked.dart';

import 'package:tripletriocore/tripletriocore.dart';

class StockViewModel extends BaseViewModel {
  LogisticsService _logisticsService = locator<LogisticsService>();
  StockControllerService _stockControllerService =
      locator<StockControllerService>();
  List<DeliveryJourney> get userJourneyList =>
      _logisticsService.userJourneyList;

  List<Product> _productList;
  List<Product> get productList => _productList;

  bool get userHasJourney =>
      userJourneyList != null && userJourneyList.length > 0;

  DeliveryJourney get currentJourney => _stockControllerService.currentJourney;

  Future fetchProduct() async {
    var result = await _stockControllerService.fetchProducts();
    return result;
  }
}
