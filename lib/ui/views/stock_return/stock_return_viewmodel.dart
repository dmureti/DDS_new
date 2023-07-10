import 'package:distributor/app/locator.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StockReturnViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _stockControllerService = locator<StockControllerService>();
  final _journeyService = locator<JourneyService>();
  final _userService = locator<UserService>();

  List<Product> _productItems = <Product>[];
  List<Product> get productItems => _productItems;

  String _reason;
  String get reason => _reason;
  updateReason(String val) {
    _reason = val;
    notifyListeners();
  }

  init() async {
    await fetchReasons();
    await fetchStockBalance();
  }

  fetchStockBalance() async {
    setBusy(true);
    var result = await _stockControllerService.getStockBalance();
    setBusy(false);
    if (result is List<Product>) {
      _productItems = result
          .where(
              (element) => !element.itemName.toLowerCase().contains('crates'))
          .toList();
      notifyListeners();
    }
    return;
  }

  void commit() async {
    DialogResponse dialogResponse = await _confirmTransactionAction();
    if (dialogResponse.confirmed) {
      // Return the crates to the branch
      _returnStocks();
    }
  }

  List _reasons = [];
  List get reasons => _reasons;

  fetchReasons() async {
    var result = await _stockControllerService.fetchReasons();
    if (result is List) {
      _reasons = result;
      _reason = _reasons.first;
      notifyListeners();
    }
    // print(result);
  }

  _returnStocks() async {
    List<SalesOrderItem> stockReturnItems = <SalesOrderItem>[];
    productItems.forEach((p) {
      SalesOrderItem s = SalesOrderItem(
          item: Product(
            quantity: p.quantity,
            itemName: p.itemName,
            itemPrice: p.itemPrice,
            id: p.itemCode,
            itemCode: p.itemCode,
          ),
          quantity: p.quantity.toInt());
      stockReturnItems.add(s);
    });
    setBusy(true);

    var result = await _stockControllerService.routeReturn(
        reason: reason,
        stockReturnItems: stockReturnItems,
        toWarehouse: _userService.user.branch,
        fromWarehouse: _journeyService.currentJourney.route);
    setBusy(false);
    if (result['status']) {
      await _dialogService.showDialog(
          title: 'Success',
          description: 'The stock was returned to the branch successfully');
      _navigationService.back(result: true);
    } else {
      await _dialogService.showDialog(
          title: 'Stock Return Failed', description: result['message']);
      _navigationService.back(result: false);
    }
    return;
  }

  _confirmTransactionAction() async {
    return await _dialogService.showConfirmationDialog(
        title: 'Return Stock Confirmation',
        description:
            'Are you sure you want to return the stock to the warehouse ? ',
        cancelTitle: 'NO',
        confirmationTitle: 'YES, I AM SURE');
  }

  setReason(e) {
    _reason = e;
    notifyListeners();
  }
}
