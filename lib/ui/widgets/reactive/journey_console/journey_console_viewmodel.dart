import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';

import 'package:distributor/services/journey_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class JourneyConsoleViewModel extends ReactiveViewModel {
  JourneyService _journeyService = locator<JourneyService>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();

  navigateToJourneyMap() async {
    await _navigationService.navigateTo(Routes.deliveryJourneyMapView,
        arguments: DeliveryJourneyMapViewArguments(
            deliveryJourney: _journeyService.currentJourney));
  }

  navigateToJourneyInfoRoute() async {
    await _navigationService.navigateTo(Routes.journeyView);
  }

  DeliveryJourney get currentJourney => _journeyService.currentJourney;

  ///The route
  String get route => currentJourney.route;

  // Total number of stops
  String get deliveryStops => _journeyService.deliveryStops.length.toString();

  /// The status of the journey
  String get journeyStatus => _journeyService.journeyStatus;

  get completionStatus => _journeyService.completionStatus;

  /// This shall initialize a journey
  Future init() async {}

  ///Select a journey
  selectJourney() {}

  updateJourneyStatus() async {
    if (journeyStatus.toLowerCase() == 'scheduled') {
      var dialogResponse = await _dialogService.showConfirmationDialog(
          title: 'Confirm Journey',
          description: 'Are you sure you want to start this journey ? ',
          confirmationTitle: 'YES');
      //Check if user has confirmed that the journey should start
      if (dialogResponse.confirmed) {
        setBusy(true);
        var result = await _journeyService.startTrip();
        setBusy(false);
        if (result) {
          notifyListeners();
          return true;
        }
      }
      //Do nothing if the user did not confirm

    } else if (journeyStatus.toLowerCase() == 'in transit') {
      setBusy(true);
      var result = await _journeyService.stopTrip();
      setBusy(false);
      if (result is bool) {
        notifyListeners();
        return true;
      }
      // else {
      //   await _dialogService.showDialog(
      //       title: 'Could not stop trip', description: result.toString());
      // }
    } else {
      return null;
    }
  }

  bool _showJourneyControls = false;
  bool get showJourneyControls {
    if (_journeyService.enableJourneyControls == true) {
      _showJourneyControls = true;
    }
    return _showJourneyControls;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_journeyService];

  navigateToMakeAdhoc() async {
    var result = await _navigationService.navigateTo(Routes.addAdhocSaleView);
  }
}
