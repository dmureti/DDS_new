import 'package:distributor/app/locator.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class RouteViewControllerViewModel extends ReactiveViewModel {
  LogisticsService _logisticsService = locator<LogisticsService>();
  DeliveryJourney get currentJourney => _logisticsService.currentJourney;
  bool get userHasJourneys {
    if (_logisticsService.userJourneyList.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_logisticsService];
}
