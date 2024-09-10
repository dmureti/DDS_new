/// This service will manage the logistics for the service
/// Service is reactive
/// When some values change, it will trigger notify listeners in whatever view models are listening
import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar/info_bar_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class LogisticsService with ReactiveServiceMixin {
  DialogService _dialogService = locator<DialogService>();
  ApiService _apiService = locator<ApiService>();
  UserService _userService = locator<UserService>();
  User get user => _userService.user;
  Api get api => _apiService.api;

  LogisticsService() {
    listenToReactiveValues([
      _userJourneyList,
      _currentJourney,
      _selectedJourney,
      _journeyState,
      _deliveryJourneyComplete
    ]);
  }

  /// Reactive user journey list
  RxValue<List<DeliveryJourney>> _userJourneyList =
      RxValue<List<DeliveryJourney>>(initial: <DeliveryJourney>[]);
  List<DeliveryJourney> get userJourneyList => _userJourneyList.value;

  /// Contains the state of the current journey
  RxValue<JourneyState> _journeyState = RxValue<JourneyState>();
  JourneyState get journeyState => _journeyState.value;

  /// Reactive current journey
  RxValue<DeliveryJourney> _currentJourney =
      RxValue<DeliveryJourney>(initial: DeliveryJourney());
  DeliveryJourney get currentJourney => _currentJourney.value;

  RxValue<DeliveryJourney> _selectedJourney =
      RxValue<DeliveryJourney>(initial: DeliveryJourney());
  DeliveryJourney get selectedJourney => _selectedJourney.value;

  RxValue<bool> _deliveryJourneyComplete = RxValue<bool>(initial: false);

  bool get deliveryJourneyComplete => _deliveryJourneyComplete.value;

  /// These are reactive
  /// Viewmodels will require reactive mixin
  updateSelectedJourney(
      {@required DeliveryJourney deliveryJourney,
      @required JourneyState journeyState}) {
    _currentJourney.value = deliveryJourney;
    _journeyState.value = journeyState;
    _selectedJourney.value = deliveryJourney;
    if (_currentJourney.value.status.toLowerCase().contains('completed')) {
      _deliveryJourneyComplete.value = true;
    } else {
      _deliveryJourneyComplete.value = false;
    }
  }

  /**
   * Get a list of [DeliveryJourney] for the signed in user
   */
  Future fetchJourneys() async {
    var result =
        await api.getDeliveryJourneyListForUser(user: user, token: user.token);
    if (result is List<DeliveryJourney>) {
      _userJourneyList.value = result;
      return result;
    } else {
      await _dialogService.showDialog(
          title: 'Error', description: result.description.toString());
      return <DeliveryJourney>[];
    }
  }

  Future<DeliveryJourney> _fetchDeliveryJourneyDetails(
      String deliveryJourneyId) async {
    DeliveryJourney deliveryJourney;
    deliveryJourney = await api.getJourneyDetails(
        token: user.token, journeyId: deliveryJourneyId);
    return deliveryJourney;
  }

  updateDeliveryJourneyStatus(DeliveryJourney deliveryJourney,
      DeliveryJourneyStatus deliveryJourneyStatus) {
    switch (deliveryJourneyStatus) {
      case DeliveryJourneyStatus.Scheduled:
        // This must be a new trip
        break;
      case DeliveryJourneyStatus.Completed:
        //@TODO : add the delivery journey to the completed delivery journey list

        //@TODO : remove this journey from the in transit delivery journey
        break;
      case DeliveryJourneyStatus.Draft:
        // Do nothing
        break;
      case DeliveryJourneyStatus.Cancelled:
        // Do nothing
        break;
      case DeliveryJourneyStatus.InTransit:
        // @TODO : Remove this journey from the scheduled deliveries

        // @TODO : Add this journey to the in transit list

        // @TODO : If the list is empty, make this the active trip
        break;
    }
  }

  Future<ActionResultService> _updateDeliveryJourneyStatus(
      DeliveryStatusTriggers deliveryStatusTriggers,
      String journeyId,
      User user) async {
    ActionResultService actionResultService;
    actionResultService = await api.postDeliveryJourneyUpdateStatus(
        deliveryStatusTriggers: deliveryStatusTriggers,
        journeyId: journeyId,
        token: user.token);
    return actionResultService;
  }

  Future updateCurrentJourney(
      {@required DeliveryJourney deliveryJourney,
      @required DeliveryStatusTriggers deliveryStatusTriggers,
      @required JourneyState journeyState}) async {
    ActionResultService _actionResultService;

    if (deliveryJourney.status == 'Scheduled') {
      _actionResultService = await _updateDeliveryJourneyStatus(
          deliveryStatusTriggers, deliveryJourney.journeyId, user);
      if (_actionResultService.actionStatus == ActionStatus.success) {
        _currentJourney.value =
            await _fetchDeliveryJourneyDetails(deliveryJourney.journeyId);
      }
    } else if (deliveryJourney.status == 'In Transit') {
      // The user wants to resume a journey
      _actionResultService = await _updateDeliveryJourneyStatus(
          deliveryStatusTriggers, deliveryJourney.journeyId, user);
      if (_actionResultService.actionStatus == ActionStatus.success) {
        _currentJourney.value =
            await _fetchDeliveryJourneyDetails(deliveryJourney.journeyId);
        _actionResultService = ActionResultService(
            actionStatus: ActionStatus.success,
            statusReportSource: StatusReportSource.user,
            message:
                'Success. Your have resumed the journey on Route ${_currentJourney.value.route}.');
      }
    } else {
      // This status cannot be changed
      _actionResultService = ActionResultService(
          actionStatus: ActionStatus.failed,
          statusReportSource: StatusReportSource.user,
          message: 'The status of this journey cannot be changed');
    }

    return _actionResultService;
  }

  // List of completedJourneys
  List<DeliveryJourney> get completedJourneys {
    var result = _userJourneyList.value.where((DeliveryJourney d) {
      return d.status.toLowerCase().trim() == 'completed';
    }).toList();
    return result;
  }

  bool get hasJourney {
    if (_userJourneyList.value.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  /// Start the ongoing [DeliveryJourney]
  startTrip() async {
    ActionResultService result = await api.postDeliveryJourneyUpdateStatus(
        deliveryStatusTriggers: DeliveryStatusTriggers.start,
        journeyId: currentJourney.journeyId,
        token: user.token);

    /// Update the status of [journeyState] to [JourneyState.onGoing]
    /// Update the [journeyState]
    if (result.actionStatus == ActionStatus.success) {
      _journeyState.value = JourneyState.onTrip;
      return true;
    } else {
      /// The update failed. Return the error string to caller
      return result.message;
    }
  }

  /// Calls the API to update the status of a [SalesOrder]
  Future makeFullSODelivery(
      String orderId, String stopId, String deliveryNoteId) async {
    var result = await api.makeFullDelivery(currentJourney.journeyId,
        salesOrderId: orderId, token: user.token, stopId: stopId);
    return result;
  }

  /// Calls the API and notifies it that a  [DeliveryJourney]
  selectTrip(DeliveryJourney deliveryJourney) async {
    var result = await api.postDeliveryJourneyUpdateStatus(
        deliveryStatusTriggers: DeliveryStatusTriggers.select,
        journeyId: deliveryJourney.journeyId,
        token: user.token);
    //Update the status of the journeyState
    return result;
  }

  /// Stop the ongoing [DeliveryJourney]
  stopTrip() async {
    var result = await api.postDeliveryJourneyUpdateStatus(
        deliveryStatusTriggers: DeliveryStatusTriggers.complete,
        journeyId: currentJourney.journeyId,
        token: user.token);

    if (result.actionStatus == ActionStatus.success) {
      cancelSelection();
      return true;
    } else {
      /// The update failed. Return the error string to caller
      return result.message;
    }
  }

  bool cancelSelection() {
    _currentJourney.value = DeliveryJourney();
    _selectedJourney.value = DeliveryJourney();
    _journeyState.value = JourneyState.idle;
    return true;
  }
}
