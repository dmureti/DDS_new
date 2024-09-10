import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class JourneySelectionWidgetViewModel extends ReactiveViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  LogisticsService _logisticsService = locator<LogisticsService>();

  int get numberOfJourneys => _logisticsService.userJourneyList
      .where((deliveryJourney) =>
          deliveryJourney.status.toLowerCase() != 'completed')
      .length;

  navigateToJourneyInfoRoute() async {
    _navigationService.navigateTo(Routes.journeyView);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_logisticsService];
}
