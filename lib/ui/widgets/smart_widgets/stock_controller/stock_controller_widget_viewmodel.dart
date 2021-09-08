import 'package:distributor/app/locator.dart';

import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StockControllerWidgetViewModel extends ReactiveViewModel {
  LogisticsService _logisticsService = locator<LogisticsService>();
  UserService _userService = locator<UserService>();

  User get user => _userService.user;

  DeliveryJourney get currentJourney => _logisticsService.selectedJourney;

  bool get hasSelectedJourney {
    if (_logisticsService.userJourneyList.length > 0 &&
            _logisticsService.currentJourney.journeyId != null ||
        user.hasSalesChannel) {
      return true;
    } else {
      return false;
    }
  }

  bool get hasJourneys {
    if (_logisticsService.userJourneyList.length > 0 || user.hasSalesChannel) {
      return true;
    } else {
      return false;
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_logisticsService];
}
