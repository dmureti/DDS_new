import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

enum JourneyState { idle, onTrip, completed, selected, scheduled }

class InfoBarWidgetViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  LogisticsService _logisticsService = locator<LogisticsService>();

  int get numberOfJourneys => _logisticsService.userJourneyList.length;

  DeliveryJourney get currentJourney => _logisticsService.currentJourney;

  JourneyState get journeyState {
    if (currentJourney.status == 'In Transit') {
      return JourneyState.onTrip;
    } else {
      return JourneyState.idle;
    }
  }

  LogisticsService get logisticsService => _logisticsService;

  navigateToJourneyInfoRoute() async {
    _navigationService.navigateTo(Routes.journeyView);
  }

  toggleJourneyState() {}

  updateJourneyState(
      {JourneyState journeyState,
      DeliveryStatusTriggers deliveryStatusTriggers,
      DeliveryJourney deliveryJourney}) async {
    setBusy(true);
    await _logisticsService.updateCurrentJourney(
        deliveryJourney: deliveryJourney,
        deliveryStatusTriggers: deliveryStatusTriggers,
        journeyState: journeyState);
    setBusy(false);
  }
}
