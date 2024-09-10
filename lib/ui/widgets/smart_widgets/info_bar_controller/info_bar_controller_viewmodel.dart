import 'package:distributor/app/locator.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class InfoBarControllerViewModel extends ReactiveViewModel {
  LogisticsService _logisticsService = locator<LogisticsService>();
  final _userService = locator<UserService>();

  User get user => _userService.user;

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
      _logisticsService.userJourneyList.length > 0 &&
      !user.hasSalesChannel;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_logisticsService];
}
