import 'package:distributor/app/locator.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StockListWidgetViewModel extends FutureViewModel<List<Product>> {
  StockControllerService _stockControllerService =
      locator<StockControllerService>();

  fetchStockBalance() async {
    List<Product> result = await _stockControllerService.getStockBalance();
    return result;
  }

  Future<List<Product>> futureToRun() async {
    List<Product> productList = await fetchStockBalance();
    return productList;
  }
}
