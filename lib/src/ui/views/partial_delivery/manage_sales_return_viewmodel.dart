import 'package:distributor/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ManageSalesReturnViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final salesOrderRequestItem;
  final int index;
  final List _reasons;

  ManageSalesReturnViewModel(
      this.salesOrderRequestItem, List reasons, this.index)
      : maxQuantity = salesOrderRequestItem['quantity'],
        _reasons = reasons {
    _salesReturns = _reasons
        .map((reason) => {
              "item": {
                "id": salesOrderRequestItem['itemCode'],
                "itemCode": salesOrderRequestItem['itemCode'],
                "itemName": salesOrderRequestItem['itemName'],
                "itemPrice": salesOrderRequestItem['itemRate'],
                // "itemFactor": salesOrderRequestItem['itemCode']
              },
              "reason": reason,
              "quantity": 0
            })
        .toList();
    // print(salesReturns.toString());
    _availableQuantity = maxQuantity;
  }

  reset() {
    _salesReturns.clear();
    notifyListeners();
  }

  final int maxQuantity;

  int _quantity = 0;
  int get quantity => _quantity;

  updateQuantity(int val) {
    _quantity += val;
    updateAvailableQuantity(val);
    notifyListeners();
  }

  int _availableQuantity;
  int get availableQuantity => _availableQuantity;

  updateAvailableQuantity(int val) {
    // Loop through the items
    int sum = 0;
    for (var salesReturn in salesReturns) {
      var result = salesReturn;
      var _quantity = result['quantity'];
      sum += _quantity;
    }
    // print(_code);
    _availableQuantity = maxQuantity - sum;
    print(sum);
    notifyListeners();
  }

  confirmSalesReturnForSKU() async {
    // print(salesReturns.toString());
    print(availableQuantity);
    //Loop through the items
    if (availableQuantity < 0) {
      await _dialogService.showDialog(
          title: 'Sales Return Validation',
          description: 'You cannot return more than the invoiced amount.');
    } else {
      _navigationService.back(result: salesReturns);
    }
  }

  List _salesReturns = [];
  List get salesReturns =>
      _salesReturns.where((element) => element['quantity'] != 0).toList();

  updateSalesReturns(int index, String value) {
    _salesReturns[index]['quantity'] = int.parse(value);
    updateQuantity(int.parse(value));
    print(salesReturns.toString());
    notifyListeners();
  }

  List _salesReturnUnitList;
  List get salesReturnUnitList => _salesReturnUnitList;

  fetchState(String reason) {}
}
