import 'package:auto_route/auto_route.dart';
import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/models/product_service.dart';
import 'package:distributor/services/adhoc_cart_service.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AdhocCartViewModel extends ReactiveViewModel {
  AdhocCartService _adhocCartService = locator<AdhocCartService>();
  StockControllerService _stockControllerService =
      locator<StockControllerService>();
  DialogService _dialogService = locator<DialogService>();
  ProductService _productService = locator<ProductService>();
  NavigationService _navigationService = locator<NavigationService>();

  num get total => _adhocCartService.total;

  navigateToAdhocPaymentView() async {
    await _navigationService.navigateTo(Routes.adhocPaymentView);
  }

  List _lists;
  List get lists => _lists;

  List<Product> _productList;
  List<Product> get productList {
    return _productList;
  }

  List<Product> _customerProductList;
  List<Product> get customerProductList => _customerProductList;

  List<Product> _stockBalanceList;
  List<Product> get stockBalanceList => _stockBalanceList;

  checkIfStockExists(Product product) {
    Product p = _stockBalanceList.firstWhere(
        (element) => element.itemCode == product.itemCode,
        orElse: () => null);
    return p != null;
  }

  final bool _isWalkin;
  final Customer _customer;

  bool get isWalkin => _isWalkin;
  Customer get customer => _customer;

  AdhocCartViewModel({@required bool isWalkin, @required Customer customer})
      : _isWalkin = isWalkin,
        _customer = customer;

  init() async {
    await fetchStockBalance();
    isWalkin ? await fetchProductsByPrice() : await fetchProducts();
    _customerProductList.removeWhere((item) => stockBalanceList.contains(item));
    notifyListeners();
  }

  Future fetchProductsByPrice() async {
    setBusy(true);
    print(_adhocCartService.sellingPriceList);
    var result = await _productService.fetchProductsByDefaultPriceList(
        defaultStock: _adhocCartService.sellingPriceList);

    setBusy(false);
    if (result is List<Product>) {
      _customerProductList = result;
      notifyListeners();
    } else {
      _customerProductList = <Product>[];
    }
  }

  Future fetchProducts() async {
    setBusy(true);
    var result = await _productService.fetchProductsByPriceList(customer);
    setBusy(false);
    if (result is List<Product>) {
      _customerProductList = result;
      notifyListeners();
    } else {
      _customerProductList = <Product>[];
      await _dialogService.showDialog(
          title: 'Error', description: 'An error occurred.');
    }
  }

  fetchStockBalance() async {
    var result = await _stockControllerService.getStockBalance();
    print(result);
    if (result is List<Product>) {
      _stockBalanceList = result;
      notifyListeners();
    } else if (result is CustomException) {
      _stockBalanceList = <Product>[];
      notifyListeners();
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_adhocCartService];
}
