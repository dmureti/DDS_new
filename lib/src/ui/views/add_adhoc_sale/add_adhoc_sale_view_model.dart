import 'package:distributor/app/locator.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AddAdhocSaleViewModel extends BaseViewModel {
  StockControllerService _stockControllerService =
      locator<StockControllerService>();

  List<Product> _productList;
  List<Product> get productList => _productList;

  fetchStockBalance() async {
    var result = await _stockControllerService.getStockBalance();
    print(result.length);
    if (result is List<Product>) {
      _productList = result;
      notifyListeners();
    }
    return result;
  }

  Customer _customer;
  Customer get customer => _customer;

  AddAdhocSaleViewModel(Customer customer) : _customer = customer;

  getSaleItems() {}
}
