import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class DeliveryJourneyViewmodel extends BaseViewModel {
  final String _deliveryJourneyId;
  final ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();

  navigateToSalesOrder(
      {String salesOrder,
      String stopId,
      DeliveryJourney deliveryJourney}) async {
    var result = await _apiService.api
        .getSalesOrderDetail(token: _user.token, orderId: salesOrder);
    if (result is SalesOrder) {
      await _navigationService.navigateTo(Routes.orderDetailViewRoute,
          arguments: OrderDetailViewArguments(
              stopId: stopId,
              salesOrder: result,
              deliveryJourney: deliveryJourney));
    } else {
      await _dialogService.showDialog(title: 'Error', description: result);
    }
  }

  Api get _api => _apiService.api;
  UserService _userService = locator<UserService>();
  User get _user => _userService.user;
  DialogService _dialogService = locator<DialogService>();

  DeliveryJourneyViewmodel({String deliveryJourneyId})
      : _deliveryJourneyId = deliveryJourneyId,
        assert(deliveryJourneyId != null);

  fetchStops() async {}

  fetchDeliveryDetails() async {
    setBusy(true);
    _deliveryJourney = await _api.getJourneyDetails(
        token: _user.token, journeyId: _deliveryJourneyId);
    setBusy(false);
    notifyListeners();
  }

  DeliveryJourney _deliveryJourney;
  DeliveryJourney get deliveryJourney => _deliveryJourney;

  Api get api => _apiService.api;

  List<DeliveryStop> _deliveryStop = List<DeliveryStop>();
  List<DeliveryStop> get deliveryStop => _deliveryJourney.stops.map((e) {
        if (e.customerId.isNotEmpty) {
          _deliveryStop.add(e);
        }
      }).toList();

  bool _reverse = false;
  bool get reverse => _reverse;
  setReverse() {
    _reverse = !_reverse;
    notifyListeners();
  }

  sortStops() {
    setReverse();
    notifyListeners();
  }
}
