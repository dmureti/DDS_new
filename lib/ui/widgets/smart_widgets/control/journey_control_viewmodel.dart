import 'package:distributor/app/locator.dart';
import 'package:distributor/services/access_controller_service.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar/info_bar_widget_viewmodel.dart';
import 'package:flutter/foundation.dart';

import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class JourneyControlIconViewModel extends BaseViewModel {
  AccessControlService _accessControlService = locator<AccessControlService>();
  LogisticsService _logisticsService = locator<LogisticsService>();

  bool _isActive;
  bool get isActive => _isActive;

  final DeliveryJourney _deliveryJourney;

  JourneyControlIconViewModel({@required DeliveryJourney deliveryJourney})
      : _deliveryJourney = deliveryJourney,
        assert(deliveryJourney != null) {
    _isActive = false;
  }

  // Check if the user has policies to change the state of a journey
  bool get enableControls => _accessControlService.enableJourneyControls;

  /// When the control is
  onTap() {
    if (_accessControlService.enableJourneyControls) {
      updateJourneyStatus();
    } else
      insufficientPermission();
  }

  updateJourneyStatus() async {
    _isActive = !_isActive;
    DeliveryStatusTriggers deliveryStatusTriggers;
    switch (_deliveryJourney.status.toLowerCase()) {
      //Start the journey
      case 'scheduled':
        deliveryStatusTriggers = DeliveryStatusTriggers.start;
        break;
      case 'in transit':
        deliveryStatusTriggers = DeliveryStatusTriggers.start;
        break;
      default:
        deliveryStatusTriggers = DeliveryStatusTriggers.start;
        break;
    }
    await _logisticsService.updateCurrentJourney(
        deliveryJourney: _deliveryJourney,
        deliveryStatusTriggers: deliveryStatusTriggers,
        journeyState: JourneyState.idle);
    notifyListeners();
  }

  insufficientPermission() {
    return null;
  }
}
