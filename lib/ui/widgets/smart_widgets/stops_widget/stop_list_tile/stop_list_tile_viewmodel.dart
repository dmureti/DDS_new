import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/user_service.dart';

import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

/// This class extends the [FutureViewModel] to enable it to fetch the [SalesOrder] corresponding to the sa
class StopListTileViewModel extends FutureViewModel<SalesOrder> {
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  LocationService _locationService = locator<LocationService>();
  JourneyService _journeyService = locator<JourneyService>();
  Api get _api => _apiService.api;
  UserService _userService = locator<UserService>();
  User get _user => _userService.user;
  final String _salesOrderId;

  List<DeliveryStop> _deliveryStop;
  List<DeliveryStop> get deliveryStop => _deliveryStop;

  SalesOrder _salesOrder;
  SalesOrder get salesOrder => _salesOrder;

  StopListTileViewModel(this._journeyId, {String salesOrderId})
      : _salesOrderId = salesOrderId,
        assert(salesOrderId != null);

  final String _journeyId;

  bool _enableStopControl = false;
  bool get enableStopControl {
    if (_journeyService.currentJourney != null &&
        _journeyService.currentJourney.journeyId == _journeyId) {
      _enableStopControl = true;
    }
    return _enableStopControl;
  }

  Future fetchSalesOrder() async {
    setBusy(true);
    var result = await _api.getSalesOrderDetail(
        token: _user.token, orderId: _salesOrderId);
    setBusy(false);
    if (result is SalesOrder) {
      _salesOrder = result;
      return result;
    } else {
      _dialogService.showDialog(
          title: 'Could not get Sales Order', description: result);
    }
  }

  bool isComplete(SalesOrder salesOrder) {
    if (salesOrder.orderStatus.toLowerCase() == 'complete') {
      return true;
    } else {
      return false;
    }
  }

  List<Placemark> _placemarkList;
  List<Placemark> get placemarkList => _placemarkList;

  getAddress(double latitude, double longitude) async {
    List<Placemark> p =
        await _locationService.placemarkFromCoordinates(latitude, longitude);
    return p;
  }

  /// When a user taps the corresponding listitem they will be redirected to the order detail view
  Future navigateToOrderDetailView(
      DeliveryJourney deliveryJourney, DeliveryStop deliveryStop) async {
    await _navigationService
        .navigateTo(Routes.orderDetailView,
            arguments: OrderDetailViewArguments(
                deliveryStop: deliveryStop,
                salesOrder: salesOrder,
                deliveryJourney: deliveryJourney,
                stopId: deliveryStop.stopId))
        .then((value) async {
      _salesOrder = await fetchSalesOrder();
      notifyListeners();
    });
  }

  @override
  Future<SalesOrder> futureToRun() async => await fetchSalesOrder();
}
