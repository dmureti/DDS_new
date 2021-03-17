import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/journey_service.dart';

import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar/info_bar_widget_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class JourneyViewModel extends ReactiveViewModel {
  final LogisticsService _logisticsService = locator<LogisticsService>();
  JourneyService _journeyService = locator<JourneyService>();
  NavigationService _navigationService = locator<NavigationService>();

  List<DeliveryJourney> get userJourneyList {
    _logisticsService.userJourneyList
        .sort((a, b) => b.status.compareTo(a.status));
    return _logisticsService.userJourneyList;
  }

  DeliveryJourney get selectedJourney => _journeyService.currentJourney;

  navigateToCustomerLocation(Customer customer) async {
    await _navigationService.navigateTo(Routes.customerLocation,
        arguments: CustomerLocationArguments(customer: customer));
  }

  void changeJourneyState(
    DeliveryJourney deliveryJourney,
  ) async {
    setBusy(true);
    DeliveryStatusTriggers deliveryStatusTriggers =
        DeliveryStatusTriggers.start;
    JourneyState journeyState;
    if (_logisticsService.currentJourney == null) {
      deliveryStatusTriggers = DeliveryStatusTriggers.start;
      journeyState = JourneyState.idle;
    } else {
      if (_logisticsService.currentJourney.journeyId ==
          deliveryJourney.journeyId) {
        journeyState = JourneyState.onTrip;
        deliveryStatusTriggers = DeliveryStatusTriggers.complete;
      }
    }
    await _logisticsService.updateCurrentJourney(
        deliveryJourney: deliveryJourney,
        deliveryStatusTriggers: deliveryStatusTriggers,
        journeyState: journeyState);
    setBusy(false);
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_logisticsService, _journeyService];
}
