import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/crate.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

enum CrateDescriptor { Green, Orange }

class CrateManagementService with ReactiveServiceMixin {
  ApiService _apiService = locator<ApiService>();
  UserService _userService = locator<UserService>();
  JourneyService _journeyService = locator<JourneyService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  DeliveryJourney get currentJourney => _journeyService.currentJourney;
  User get _user => _userService.user;

  String get userToken => _user.token;

  bool _hasConfirmedStock = false;
  bool get hasConfirmedStock => _hasConfirmedStock;

  receiveCratesFromCustomer() async {}

  // For crates transfer and return the details property shall be filled with the journey ID.
  // e.g. For crates return
  // Return crates
  cratesReturn({@required List<Product> items}) async {
    Map<String, dynamic> data = {
      "details": currentJourney.journeyId,
      "fromWarehouse": _journeyService.currentJourney.route ??
          _userService.user.salesChannel,
      "toWarehouse": _userService.user.branch,
      "items": items
          .map((e) => {
                "item": {
                  "id": e.id,
                  "itemCode": e.itemCode,
                  "itemName": e.itemName,
                  "itemPrice": e.itemPrice
                },
                "quantity": e.quantity
              })
          .toList()
    };
    var result =
        await _apiService.api.returnCrates(token: userToken, data: data);
    return result;
  }

  //Transfer crates
  transferCrates() async {}

  /// Fetch the products
  /// Filtered by the string
  fetchCrates() async {
    var productList = await _apiService.api.getStockBalance(
        token: userToken, branchId: currentJourney.route ?? _user.salesChannel);
    if (productList is List<Product>) {
      if (productList.isNotEmpty) {
        return productList.where((product) => product.isCrate == true).toList();
      } else {
        return <Product>[];
      }
    } else {
      if (productList is CustomException) {
        await _dialogService.showDialog(
            title: productList.title, description: productList.description);
        return <Product>[];
      }
    }
  }

  collectDropCrates(
      {@required String customer,
      @required String dnId,
      @required int received,
      @required dropped,
      @required List<SalesOrderItem> items,
      String journeyId}) async {
    final String company = "Mini Bakeries (Mombasa) Limited";
    final String purpose = "Material Receipt";
    const String warehouseType = "Virtual Warehouse";
    final Map<String, dynamic> details = {
      "jnId": currentJourney.journeyId ?? journeyId,
      "customer": customer,
      "dnId": dnId,
      "received": received,
      "dropped": dropped
    };
    Map<String, dynamic> data = {
      "items": items
          .map((e) => {
                "item": {
                  "id": e.item.id,
                  "itemCode": e.item.itemCode,
                  "itemName": e.item.itemName,
                  "itemPrice": e.item.itemPrice
                },
                "quantity": e.quantity
              })
          .toList(),
      "purpose": purpose,
      "details": details.toString(),
      "toWarehouse": {
        "company": company,
        "id": _journeyService.currentJourney.route ??
            _userService.user.salesChannel,
        "name": _journeyService.currentJourney.route ??
            _userService.user.salesChannel,
        "warehouseType": warehouseType
      }
    };
    var result =
        await _apiService.api.collectDropCrates(token: userToken, data: data);
    return result;
  }
}
