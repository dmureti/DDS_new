import 'package:distributor/app/locator.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class InfoBarControllerViewModel extends ReactiveViewModel {
  LogisticsService _logisticsService = locator<LogisticsService>();

  DeliveryJourney get currentJourney => _logisticsService.selectedJourney;

  bool get hasSelectedJourney {
    if (currentJourney.journeyId == null) {
      return false;
    } else {
      return true;
    }
  }

  get userHasJourneys =>
      _logisticsService.userJourneyList != null &&
      _logisticsService.userJourneyList.length > 0;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_logisticsService];
}
