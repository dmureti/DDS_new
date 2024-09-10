import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SwitchControlViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  navigateToJourneyInfoRoute() async {
    await _navigationService.navigateTo(Routes.journeyView);
  }
}
