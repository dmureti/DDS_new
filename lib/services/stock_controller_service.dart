import 'package:distributor/app/locator.dart';
import 'package:distributor/services/access_controller_service.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/user_service.dart';

import 'package:tripletriocore/tripletriocore.dart';

class StockControllerService {
  AccessControlService _accessControlService = locator<AccessControlService>();
  JourneyService _journeyService = locator<JourneyService>();
  DeliveryJourney get currentJourney => _journeyService.currentJourney;

  ApiService _apiService = locator<ApiService>();
  Api get _api => _apiService.api;
  UserService _userService = locator<UserService>();
  User get _user => _userService.user;

  bool _hasJourney = false;
  bool get hasJourney => _hasJourney;

//	Stock balance tab on L1 app is enabled if the user has
//	"virtual_stock_balance.view".
//	When the balances are displayed, the specific column "value of stock"
//	should only be displayed if the user has "virtual_stock_balance.view_cog" permission;
//	otherwise, hide this column

  List<Product> _productList;
  List<Product> get productList => _productList;

  bool get enableProductTab => _accessControlService.enableStockTab;

  Future fetchProducts() async {
    return await _api.fetchAllProducts(_user.token);
  }

  fetchStockBalance() {
    bool result = false;
    if (_accessControlService.enableStockTab) {
      // Fetch the stock balance
      result = true;
    }
    return result;
  }

  bool showValueOfStock() {
    bool result = false;
    if (_accessControlService.displayValueOfStockColumn) {
      result = true;
    }
    return result;
  }

  getStockBalance() async {
    var result = await _api.getStockBalance(
        token: _user.token, branchId: currentJourney.route);
    return result;
  }

  getUserPOSProfile() async {
    var result =
        await _api.getUserPOSProfile(token: _user.token, userId: _user.id);

    return result;
  }
}
