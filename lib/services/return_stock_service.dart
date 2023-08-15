import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

@lazySingleton
class ReturnStockService {
  UserService _userService = locator<UserService>();
  ApiService _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();
  final _stockControllerService = locator<StockControllerService>();
  Api get api => _apiService.api;

  User get user => _userService.user;
  String get userChannel => user.salesChannel;

  List<Product> _itemsToReturn = <Product>[];
  List<Product> get itemsToReturn => _itemsToReturn;

  bool get canReturn => itemsToReturn != null && itemsToReturn.isNotEmpty;

  reset() {
    _itemsToReturn = [];
  }

  List<Product> _productList = <Product>[];
  List<Product> get productList => _productList;

  fetchStockBalance() async {
    var result = await _stockControllerService.getStockBalance();
    print("in fetch stock balance");
    print(result);
    if (result is List<Product>) {
      _productList = result;
      return productList;
    } else if (result is CustomException) {
      _productList = <Product>[];
      await _dialogService.showDialog(
          title: result.title, description: result.description);
      return <Product>[];
    }
  }

  returnItems() async {
    DialogResponse dialogResponse = await _dialogService.showConfirmationDialog(
        title: 'Stock Return Confirmation',
        description: 'Are you sure you want to return stock to the branch ?',
        confirmationTitle: 'Yes',
        cancelTitle: 'NO');
    if (dialogResponse.confirmed) {
      if (itemsToReturn.isEmpty) {
        var result = await fetchStockBalance();
        _itemsToReturn = result;
      }
      StockTransferRequest stockTransferRequest = StockTransferRequest(
          fromWarehouse: userChannel,
          toWarehouse: user.branch,
          items: itemsToReturn);
      // print(stockTransferRequest.toJson());
      var result = await api.shopReturn(user.token,
          stockTransferData: stockTransferRequest.toJson());
      if (result is String) {
        await _dialogService.showDialog(title: 'Error', description: result);
        return false;
      } else {
        await _dialogService.showDialog(
            title: 'Success',
            description:
                'The stock was returned successfully.Use the Pending Stock Transactions Button to commit this transaction.');
        return true;
      }
    }
  }

  void updateItemsToReturn(Product product) {
    if (itemsToReturn.isNotEmpty) {
      int index =
          itemsToReturn.indexWhere((p) => p.itemCode == product.itemCode);
      if (index.isNegative && product.quantity > 0) {
        _itemsToReturn.add(product);
      } else {
        //The index is positive
        //The element exists
        if (product.quantity <= 0) {
          //Remove this item
          _itemsToReturn.removeAt(index);
        } else {
          //Replace the value at this index since it is not zero
          _itemsToReturn[index] = product;
        }
      }
    } else {
      if (product.quantity > 0) {
        _itemsToReturn.add(product);
      }
    }
    return;
  }
}
