import 'package:distributor/ui/widgets/smart_widgets/info_bar/info_bar_widget_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:enum_to_string/enum_to_string.dart';

// Handles state information for logistics
//@TODO: Delete methods after API is implemented
class LogisticsModel extends BaseModel {
  final Api api;
  final User user;
  final String token;

  DeliveryJourney _currentJourney;

  // List of completedJourneys
  List<DeliveryJourney> _completedJourneys = <DeliveryJourney>[];

  List<DeliveryJourney> get completedJourneys {
    var result = _userJourneyList.where((DeliveryJourney d) {
      return d.status.toLowerCase().trim() == 'completed';
    }).toList();
    _completedJourneys.addAll(result);
    return _completedJourneys;
  }

  void addCompletedJourney(DeliveryJourney deliveryJourney) {
    _completedJourneys.add(deliveryJourney);
    notifyListeners();
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
    notifyListeners();
  }

  // List of active / In Transir journeys
  List<DeliveryJourney> _inTransitJourneys = <DeliveryJourney>[];
  List<DeliveryJourney> get inTransitJourneys {
    var result = _userJourneyList.where((DeliveryJourney d) {
      return d.status.toLowerCase().trim() == 'in transit';
    }).toList();
    _inTransitJourneys.addAll(result);
    return _inTransitJourneys;
  }

  addInTransitJourney(DeliveryJourney deliveryJourney) {
    _inTransitJourneys.add(deliveryJourney);
    notifyListeners();
  }

  // List of scheduled journeys
  List<DeliveryJourney> get scheduledJourneys {
    List<DeliveryJourney> _scheduledJourneys = <DeliveryJourney>[];
    var result = userJourneyList.where((DeliveryJourney d) {
      return d.status.toLowerCase().trim() == 'scheduled';
    }).toList();
    _scheduledJourneys.addAll(result);
    return _scheduledJourneys;
  }

  DeliveryJourney get currentJourney => _currentJourney;

  JourneyState _journeyState = JourneyState.idle;
  JourneyState get journeyState => _journeyState;
  updateJourneyState(JourneyState journeyState) {
    _journeyState = journeyState;
    notifyListeners();
  }

  /// Update the active journey
  Future<ActionResultService> updateCurrentJourney(
      {@required DeliveryJourney deliveryJourney,
      @required DeliveryStatusTriggers deliveryStatusTriggers,
      @required JourneyState journeyState}) async {
    ActionResultService _actionResultService;
    setBusy(true);
    if (deliveryJourney.status == 'Scheduled') {
      _actionResultService = await _updateDeliveryJourneyStatus(
          deliveryStatusTriggers, deliveryJourney.journeyId, user);
      if (_actionResultService.actionStatus == ActionStatus.success) {
        _currentJourney =
            await _fetchDeliveryJourneyDetails(deliveryJourney.journeyId);
      }
    } else if (deliveryJourney.status == 'In Transit') {
      // The user wants to resume a journey
      _actionResultService = await _updateDeliveryJourneyStatus(
          deliveryStatusTriggers, deliveryJourney.journeyId, user);
      if (_actionResultService.actionStatus == ActionStatus.success) {
        _currentJourney =
            await _fetchDeliveryJourneyDetails(deliveryJourney.journeyId);
        _actionResultService = ActionResultService(
            actionStatus: ActionStatus.success,
            statusReportSource: StatusReportSource.user,
            message:
                'Success. Your have resumed the journey on Route ${_currentJourney.route}.');
      }
    } else {
      // This status cannot be changed
      _actionResultService = ActionResultService(
          actionStatus: ActionStatus.failed,
          statusReportSource: StatusReportSource.user,
          message: 'The status of this journey cannot be changed');
      debugPrint('This status cannot be changed');
    }
    setBusy(false);
    return _actionResultService;
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

  /// Get the details of a journey
  Future<DeliveryJourney> _fetchDeliveryJourneyDetails(
      String deliveryJourneyId) async {
    DeliveryJourney deliveryJourney;
    deliveryJourney = await api.getJourneyDetails(
        token: user.token, journeyId: deliveryJourneyId);
    return deliveryJourney;
  }

  LogisticsModel(
      {@required this.api, @required this.user, @required this.token})
      : assert(token != null, user != null);

  bool get userHasDeliveries {
    if (userJourneyList == null || userJourneyList.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  List<DeliveryJourney> _userJourneyList;
  List<DeliveryJourney> get userJourneyList {
    if (_userJourneyList == null) {
      _userJourneyList = <DeliveryJourney>[];
    }
    return _userJourneyList;
  }

  init() async {
    await fetchJourneys();
  }

  // Fetch a users journey
  Future<List<DeliveryJourney>> fetchJourneys() async {
    Map<ActionResultService, List<DeliveryJourney>> resultMap =
        await api.getDeliveryJourneyListForUser(user: user, token: token);
    ActionResultService actionResultService = resultMap.keys.first;
    if (actionResultService.actionStatus == ActionStatus.success) {
      List<DeliveryJourney> result = resultMap.values.first;
      _userJourneyList = result;
    } else {
      debugPrint(actionResultService.message);
    }
    return _userJourneyList;
  }

  Future<SalesOrder> getSalesOrderDetail(String salesOrderId) async {
//    setBusy(true);
    SalesOrder _salesOrder;
    Map<ActionResultService, SalesOrder> result =
        await api.getSalesOrderDetail(token: user.token, orderId: salesOrderId);
    if (result.keys.first.actionStatus == ActionStatus.success) {
      _salesOrder = result.values.first;
    } else {
      print('logisticsservice' + result.keys.first.message);
    }
//    setBusy(false);
    return _salesOrder;
  }

  List<DeliveryJourney> filterDeliveryJourneyByStatus(
      DeliveryJourneyStatus deliveryJourneyStatus) {
    String status = EnumToString.convertToString(deliveryJourneyStatus);
    List<DeliveryJourney> _result = <DeliveryJourney>[];
    //Loop through the results
    _result = _userJourneyList.where((DeliveryJourney j) {
      return j.status.trim().toLowerCase() == status.trim().toLowerCase();
    }).toList();
    return _result;
  }
}
