import 'package:distributor/app/locator.dart';
import 'package:distributor/services/activity_service.dart';
import 'package:distributor/services/crate_,management_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:distributor/services/transaction_service.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar/info_bar_widget_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

/// Uses the [ReactiveViewModel] to enable it to listen to changes in the state of [JourneyState]
class SelectControlWidgetViewModel extends ReactiveViewModel {
  LogisticsService _logisticsService = locator<LogisticsService>();
  ActivityService _activityService = locator<ActivityService>();
  JourneyService _journeyService = locator<JourneyService>();
  DialogService _dialogService = locator<DialogService>();
  final _transactionService = locator<TransactionService>();
  final _stockControllerService = locator<StockControllerService>();
  final _crateManagementService = locator<CrateManagementService>();
  final DeliveryJourney _deliveryJourney;

  DeliveryJourney get selectedDeliveryJourney => _journeyService.currentJourney;

  bool get isCurrentSelection {
    if (selectedDeliveryJourney.journeyId == _deliveryJourney.journeyId) {
      return true;
    }
    return false;
  }

  fetchStockBalance() async {
    setBusy(true);
    await _stockControllerService.getStockBalance();
    setBusy(false);
  }

  fetchCrateTransactions() async {
    setBusy(true);
    await _crateManagementService.fetchCrates();
    setBusy(false);
  }

  cancelSelectedJourney() {
    _logisticsService.cancelSelection();
    _journeyService.cancelSelection();
  }

  SelectControlWidgetViewModel({@required DeliveryJourney deliveryJourney})
      : assert(deliveryJourney != null),
        _deliveryJourney = deliveryJourney;

  /// This will create an app based session of the selected [DeliveryJourney]
  /// It does not make persistent changes on the [API]
  toggleSelectedJourney(DeliveryJourney deliveryJourney) async {
    //Check if the selected journey is same as current journey
    if (selectedDeliveryJourney.journeyId == _deliveryJourney.journeyId) {
      cancelSelectedJourney();
      await _transactionService.init();
      _activityService.addActivity(Activity(
          activityTitle: '${deliveryJourney.journeyId} deselected',
          activityDesc: '${deliveryJourney.journeyId} deselected'));
    } else {
      setBusy(true);

      /// Initialize the [JourneyState] of the current [DeliveryJourney] with idle
      JourneyState journeyState = JourneyState.idle;
      _logisticsService.updateSelectedJourney(
          deliveryJourney: deliveryJourney, journeyState: journeyState);
      _journeyService.updateSelectedJourney(
          deliveryJourney: deliveryJourney,
          journeyState: JourneyState.selected);
      var result = await _journeyService.init(deliveryJourney.journeyId);
      _transactionService.init();
      setBusy(false);
      if (result is bool) {
        await fetchStockBalance();

        _activityService.addActivity(Activity(
            activityTitle: '${deliveryJourney.journeyId} selected',
            activityDesc: '${deliveryJourney.journeyId} selected'));
        // Notify the user that they need to start the journey
        notifyListeners();
      } else {
        await _dialogService.showDialog(
            title: 'Could not fetch delivery', description: result.toString());
      }
    }

    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_logisticsService, _activityService, _journeyService];
}
