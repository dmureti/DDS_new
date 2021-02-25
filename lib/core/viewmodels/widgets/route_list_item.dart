import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';

import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:stacked/stacked.dart';

class RouteListItemViewmodel extends BaseViewModel {
  ApiService _apiService = locator<ApiService>();
  Api get _api => _apiService.api;

  UserService _userService = locator<UserService>();
  User get _user => _userService.user;

  String _deliveryJourneyId;
  String get deliveryJourneyId => _deliveryJourneyId;

  DeliveryJourney _deliveryJourney;
  DeliveryJourney get deliveryJourney => _deliveryJourney;

  RouteListItemViewmodel({
    @required DeliveryJourney deliveryJourney,
  })  : _deliveryJourney = deliveryJourney,
        assert(deliveryJourney != null);

  init() async {
    setBusy(true);
    _deliveryJourney = await getJourneyDetails();
    setBusy(false);
  }

  getJourneyDetails() async {
    DeliveryJourney deliveryJourneydetailed = await _api.getJourneyDetails(
        token: _user.token, journeyId: _deliveryJourneyId);
    return deliveryJourneydetailed;
  }
}
