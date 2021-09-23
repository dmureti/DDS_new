import 'package:distributor/app/locator.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StockListWidgetViewModel extends BaseViewModel {
  DialogService _dialogService = locator<DialogService>();
  StockControllerService _stockControllerService =
      locator<StockControllerService>();

  List<Product> _productList;

  StockListWidgetViewModel(this.rebuildTree) {
    print(this.rebuildTree);
    if (rebuildTree) {
      fetchStockBalance();
    }
  }

  List<Product> get productList => _productList;

  final bool rebuildTree;

  init() async {
    await fetchStockBalance();
  }

  fetchStockBalance() async {
    var result = await _stockControllerService.getStockBalance();
    if (result is List<Product>) {
      _productList = result;
      print('rebuilt');
      notifyListeners();
    } else if (result is CustomException) {
      _productList = List<Product>();
      print('no_rebuild');
      notifyListeners();
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    }
  }
}
