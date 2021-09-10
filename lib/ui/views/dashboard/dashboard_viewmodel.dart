import 'package:distributor/app/locator.dart';
import 'package:distributor/services/access_controller_service.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/user_service.dart';

import 'package:distributor/traits/contextual_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class DashboardViewModel extends FutureViewModel<List<DeliveryJourney>>
    with ContextualViewmodel {
  LogisticsService _logisticsService = locator<LogisticsService>();
  UserService _userService = locator<UserService>();
  DialogService _dialogService = locator<DialogService>();
  AccessControlService _accessControlService = locator<AccessControlService>();

  User get user => _userService.user;
  bool get hasJourney => _logisticsService.hasJourney;
  final String formattedDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());

  //Check if user can list journeys
  bool get canListJourneys => _accessControlService.enableJourneyTab;

  Future fetchUserJourneys() async {
    var result = await _logisticsService.fetchJourneys();
    return result;
  }

  @override
  Future<List<DeliveryJourney>> futureToRun() async {
    List<DeliveryJourney> result = await fetchUserJourneys();

    return result;
  }

  @override
  void onData(List<DeliveryJourney> data) {
    // SystemNavigator.pop();
    super.onData(data);
  }

  @override
  void onError(error) async {
    await _dialogService.showDialog(
        title: 'Error', description: error.toString());
    super.onError(error);
  }

  init() async {
    await _logisticsService.fetchJourneys();
  }

  UserSummary _userSummary;
  UserSummary get userSummary => _userSummary;
}
