import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CrateTransactionListingViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _userService = locator<UserService>();
  final _journeyService = locator<JourneyService>();
  final _logisticsService = locator<LogisticsService>();
  final _dialogService = locator<DialogService>();

  bool get hasJourney => _journeyService.hasJourney;

  CrateTransactionListingViewModel();

  get token => _userService.user.token;

  List _crateTransactionListings;
  List get crateTransactionListings => _crateTransactionListings ?? [];

  bool get hasSelectedJourney {
    if (_logisticsService.userJourneyList.length > 0 &&
            _logisticsService.currentJourney.journeyId != null ||
        user.hasSalesChannel) {
      return true;
    } else {
      return false;
    }
  }

  User get user => _userService.user;

  init() async {
    if (_journeyService.hasJourney) {
      await getCrateTransactions();
    }
  }

  getCrateTransactions() async {
    setBusy(true);
    var result = await _apiService.api.getJourneyCratesTransactions(
        token: token, journeryId: _journeyService.journeyId);
    setBusy(false);
    if (result is CustomException) {
      await _dialogService.showDialog(
          title: 'Error', description: result.description);
      return;
    } else {
      _crateTransactionListings = result;
      notifyListeners();
    }
  }
}
