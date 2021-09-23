import 'package:distributor/app/locator.dart';
import 'package:distributor/services/return_stock_service.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:distributor/traits/contextual_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StockTransferViewmodel extends BaseViewModel with ContextualViewmodel {
  DialogService _dialogService = locator<DialogService>();
  StockControllerService _stockControllerService =
      locator<StockControllerService>();
  final _returnStockService = locator<ReturnStockService>();
  final _navigationService = locator<NavigationService>();

  List<Product> _productList;
  List<Product> get productList => _productList;

  init() async {
    _returnStockService.reset();
    await fetchStockBalance();
  }

  fetchStockBalance() async {
    var result = await _stockControllerService.getStockBalance();
    if (result is List<Product>) {
      _productList = result;
      notifyListeners();
    } else if (result is CustomException) {
      _productList = List<Product>();
      notifyListeners();
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    }
  }

  bool get enableReturnToBranch => _returnStockService.canReturn;

  transferStock() async {
    setBusy(true);
    var result = await _returnStockService.returnItems();
    setBusy(false);
    _navigationService.back(result: result);
  }

  void reset() async {
    _returnStockService.reset();
    notifyListeners();
  }

  onChange(Product product) {
    // print('I have changed ${product.quantity} pcs to ${product.itemName}');
    _returnStockService.updateItemsToReturn(product);
    notifyListeners();
  }
}
