import 'package:distributor/app/locator.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class DashboardViewControllerViewModel extends ReactiveViewModel {
  LogisticsService _logisticsService = locator<LogisticsService>();
  UserService _userService = locator<UserService>();

  User get user => _userService.user;
  List<DeliveryJourney> get userJourneyList =>
      _logisticsService.userJourneyList;

  bool get userHasJourneys =>
      _logisticsService.userJourneyList != null &&
          _logisticsService.userJourneyList.length > 0 ||
      user.hasSalesChannel;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_logisticsService];
}
