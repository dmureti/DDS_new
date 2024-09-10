import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';

import 'package:distributor/services/logistics_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class MapIconButtonViewModel extends ReactiveViewModel {
  LogisticsService _logisticsService = locator<LogisticsService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  DeliveryJourney get currentJourney => _logisticsService.currentJourney;
  DeliveryJourney get selectedJourney => _logisticsService.selectedJourney;
  bool get onTrip {
    if (selectedJourney.journeyId != null &&
        selectedJourney.journeyId.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  navigateToJourneyMapView() async {
    if (onTrip == true) {
      _navigationService.navigateTo(Routes.deliveryJourneyMapView,
          arguments:
              DeliveryJourneyMapViewArguments(deliveryJourney: currentJourney));
    } else {
      await _dialogService.showDialog(
          title: 'Select a Journey',
          description: 'Please select a journey to see the stops');
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_logisticsService];
}
