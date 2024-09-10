import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';

import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ViewMapButtonViewModel extends FutureViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  UserService _userService = locator<UserService>();
  ApiService _apiService = locator<ApiService>();
  Api get _api => _apiService.api;
  User get _user => _userService.user;

  DeliveryJourney _deliveryJourney;

  DeliveryJourney get deliveryJourney => _deliveryJourney;
  final String _journeyId;

  navigateToViewMap() {
    //If the deliveru journey is null
    _navigationService.navigateTo(Routes.deliveryJourneyMapView,
        arguments:
            DeliveryJourneyMapViewArguments(deliveryJourney: _deliveryJourney));
  }

  ViewMapButtonViewModel(this._journeyId);

  Future getJourneyDetails() async {
    var result =
        await _api.getJourneyDetails(token: _user.token, journeyId: _journeyId);
    if (result is DeliveryJourney) {
      _deliveryJourney = result;
      notifyListeners();
    }
    print(result);
    return _deliveryJourney;
  }

  List<Customer> _customerList;
  List<Customer> get customerList => _customerList;

  @override
  Future futureToRun() async {
    var result = await getJourneyDetails();
    return result;
  }
}
