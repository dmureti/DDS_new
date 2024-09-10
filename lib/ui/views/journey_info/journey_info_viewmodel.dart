import 'package:distributor/app/locator.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:stacked/stacked.dart';

class JourneyInfoViewModel extends BaseViewModel {
  final journeyService = locator<JourneyService>();

  init() async {
    await fetchJourneyLocationStats();
  }

  fetchJourneyLocationStats() async {
    setBusy(true);
    await journeyService.fetchLocationStats();
    setBusy(false);
  }
}
