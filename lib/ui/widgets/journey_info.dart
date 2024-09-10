import 'package:distributor/app/locator.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar/info_bar_widget_viewmodel.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/core/helper.dart';
import 'package:distributor/ui/shared/text_styles.dart';
import 'package:distributor/ui/shared/widgets.dart';
import 'package:flutter/material.dart';

// This widget will give the user critical information related to a journey

class JourneyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logisticsModel = locator<LogisticsService>();
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.pinkAccent, width: 3),
        ),
        child: logisticsModel.currentJourney != null
            ? Material(
                color: Colors.pink,
                type: MaterialType.card,
                elevation: 4,
                borderRadius: BorderRadius.circular(5),
                borderOnForeground: true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      // The details of the current journey
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('${logisticsModel.currentJourney.status}'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  '${logisticsModel.currentJourney.journeyId} '),
                            ],
                          ),
                          Text(
                              'Route : ${logisticsModel.currentJourney.route}'),
                          Text(
                              'Vehicle ${Helper.formatRegistration(logisticsModel.currentJourney.vehicle)}'),
                        ],
                      ),
                      // The number of deliveries
                      VerticalDivider(
                        width: 10.0,
                        thickness: 2,
                        color: Colors.pink,
                      ),
                      Container(
                        child: Text('${logisticsModel.userJourneyList.length}'),
                      ),
                      VerticalDivider(
                        width: 10.0,
                        thickness: 2,
                        color: Colors.pink,
                      ),
                      Container(
                        child: Text(
                            '${logisticsModel.currentJourney.stops.length}'),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.swap_horizontal_circle),
                          onPressed: () {
                            showJourneyModalSheet(context, logisticsModel);
                          },
                        ),
                      )

                      // The number of stops

                      // The number of orders
                    ],
                  ),
                ),
              )
            : logisticsModel.userJourneyList.length > 0
                ? Material(
                    type: MaterialType.card,
                    color: Colors.pink,
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'You don\'t have an active journey.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Select a journey to proceed.'),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () async {
                              ActionResultService result =
                                  await showJourneyModalSheet(
                                      context, logisticsModel);
                              // The result will be null if the user closed the bottom nav
                              if (result != null) {
                                if (result.actionStatus ==
                                    ActionStatus.success) {
                                  // The user successfully changed the status of the trip
                                  final snackbar = SnackBar(
                                    content: Text(
                                      '\u{1F642} ${result.message}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    backgroundColor: Colors.green,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                } else {
                                  // The status of the journey has not been changed
                                  // @TODO : Show a snackbar to notify the user that the status has not changed.
                                  final snackbar = SnackBar(
                                    content: Text(
                                      '\u{1F61F} ${result.message}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text('You have not been assigned any journey today.'),
                  ));
  }

  Future<ActionResultService> showJourneyModalSheet(
      BuildContext context, LogisticsService model) {
    return showModalBottomSheet<ActionResultService>(
        context: context,
        builder: (context) => Container(
              margin: EdgeInsets.only(top: 5, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BottomModalSheetTitle(
                      title: model.currentJourney == null
                          ? 'Select a Journey'
                          : 'Select the journey you want to switch to'),
                  Text(
                    'You have ${model.userJourneyList.length} journey(s) to complete today. Click on it to see the stop/orders',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  ...model.userJourneyList
                      .map((e) => ListTile(
                            contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            title: Text(
                              e.route,
                              style: kModalBottomSheetListTileTitle,
                            ),
                            subtitle: Text(e.journeyId,
                                style: kModalBottomSheetListTileTitle),
                            trailing: model.currentJourney != null
                                ? model.currentJourney.journeyId == e.journeyId
                                    ? Container(
                                        color: Colors.pink,
                                        width: 20.0,
                                        height: 20.0,
                                      )
                                    : Text(
                                        '${e.status}',
                                      )
                                : Text(
                                    '${e.status}',
                                  ),
                            onTap: () async {
                              ActionResultService _actionResultService;
                              DeliveryStatusTriggers _deliveryStatusTriggers;
                              switch (e.status.toLowerCase()) {
                                case 'scheduled':
                                  //Display an alert dialog
                                  await showDialog<bool>(
                                      context: (context),
                                      builder: (dialogContext) => AlertDialog(
                                            title: Text(
                                                'Confirm Journey ${e.journeyId}'),
                                            content: Text(
                                                'Do you want to start on this journey on Route : ${e.route} ?\nClick Cancel to select another journey OR Confirm to continue.'),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: Text('Confirm'),
                                                onPressed: () {
                                                  Navigator.pop(
                                                      dialogContext, true);
                                                },
                                              ),
                                              ElevatedButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.pop(
                                                      dialogContext, false);
                                                },
                                              )
                                            ],
                                          )).then((bool result) {
                                    if (result) {
                                      _deliveryStatusTriggers =
                                          DeliveryStatusTriggers.start;
                                    } else {
                                      _actionResultService = ActionResultService(
                                          actionStatus: ActionStatus.cancel,
                                          message:
                                              'You did not change the status of any trip.');
                                    }
                                  });
                                  break;
                                case 'in transit':
                                  await showDialog<bool>(
                                      context: (context),
                                      builder: (dialogContext) => AlertDialog(
                                            title: Text(
                                                'Confirm Journey ${e.journeyId}'),
                                            content: Text(
                                                'Do you want to continue with this journey on Route : ${e.route} ?\nClick Cancel to select another journey OR Confirm to continue.'),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: Text('Confirm'),
                                                onPressed: () {
                                                  Navigator.pop(
                                                      dialogContext, true);
                                                },
                                              ),
                                              ElevatedButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.pop(
                                                      dialogContext, false);
                                                },
                                              )
                                            ],
                                          )).then((bool result) {
                                    if (result) {
                                      _deliveryStatusTriggers =
                                          DeliveryStatusTriggers.start;
                                    } else {
                                      _actionResultService = ActionResultService(
                                          actionStatus: ActionStatus.cancel,
                                          message:
                                              'You did not change the status of the journey.');
                                    }
                                  });
                                  break;
                              }
                              // Using the current status of the journey create a delivery trigger.
                              // If the trigger is not null, this is a valid journey
                              if (_deliveryStatusTriggers != null) {
                                _actionResultService =
                                    await model.updateCurrentJourney(
                                        deliveryJourney: e,
                                        deliveryStatusTriggers:
                                            _deliveryStatusTriggers,
                                        journeyState: JourneyState.idle);
                                Navigator.pop(context, _actionResultService);
                              } else {
                                if (_actionResultService == null) {
                                  _actionResultService = ActionResultService(
                                      actionStatus: ActionStatus.failed,
                                      message:
                                          'You can\'t change the status of this trip');
                                  Navigator.pop(context, _actionResultService);
                                }
                              }
                            },
                          ))
                      .toList()
                ],
              ),
            ));
  }
}
