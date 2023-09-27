import 'package:distributor/app/locator.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AddAdhocSaleViewModel extends BaseViewModel {
  DialogService _dialogService = locator<DialogService>();
  StockControllerService _stockControllerService =
      locator<StockControllerService>();

  List<Product> _productList;
  List<Product> get productList => _productList;

  fetchStockBalance() async {
    var result = await _stockControllerService.getStockBalance();
    if (result is List<Product>) {
      _productList = result;
      notifyListeners();
    } else if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
      _productList = <Product>[];
      notifyListeners();
    }
  }

  Customer _customer;
  Customer get customer => _customer;

  AddAdhocSaleViewModel(Customer customer) : _customer = customer;
}
