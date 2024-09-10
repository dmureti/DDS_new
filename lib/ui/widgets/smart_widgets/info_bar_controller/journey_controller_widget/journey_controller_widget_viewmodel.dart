import 'package:distributor/app/locator.dart';
import 'package:distributor/services/access_controller_service.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar/info_bar_widget_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class JourneyControllerWidgetViewModel extends ReactiveViewModel {
  LogisticsService _logisticsService = locator<LogisticsService>();
  AccessControlService _accessControlService = locator<AccessControlService>();
  DialogService _dialogService = locator<DialogService>();

  DeliveryJourney get currentJourney => _logisticsService.selectedJourney;

  JourneyState get journeyState => _logisticsService.journeyState;
  String get tripState {
    switch (journeyState) {
      case JourneyState.idle:
        return 'Not Started';
        break;
      case JourneyState.onTrip:
        return 'Ongoing';
        break;
      default:
        return 'Unknown';
        break;
    }
  }

  bool get enableControls => _accessControlService.enableJourneyControls;
  bool get deliveryJourneyComplete => _logisticsService.deliveryJourneyComplete;

  updateJourneyState() async {
    setBusy(true);
    // Start the trip
    // 'Journey ${model.currentJourney.journeyId} has been started.'
    if (journeyState == JourneyState.idle) {
      var result = await _logisticsService.startTrip();
      if (result is String) {
        _dialogService.showDialog(
            title: 'Could not start the trip', description: result);
      }
    } else if (journeyState == JourneyState.onTrip) {
      var result = await _logisticsService.stopTrip();
      if (result is String) {
        _dialogService.showDialog(
            title: 'Could not stop the trip', description: result);
      }
    }
    //Stop the trip
    // 'Journey ${model.currentJourney.journeyId} has been stopped.'
    setBusy(false);
  }

  //What happens when the user presses a control
  onControlPressed() async {
    //Check if the user has permissions
    bool canControl = _accessControlService.enableJourneyControls;
    if (canControl) {
      /// The user can control
      /// Update the icon
    } else {
      return null;
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_logisticsService];
}
