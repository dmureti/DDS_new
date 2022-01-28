import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:distributor/ui/widgets/reactive/journey_console/journey_console_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class JourneyConsole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneyConsoleViewModel>.reactive(
        builder: (context, model, child) => model.currentJourney == null
            ? Container()
            : Container(
                color: Colors.pink,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: [0, 0.9],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black87,
                            Colors.pinkAccent,
                          ],
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.pink.withOpacity(0.9),
                      shadowColor: Colors.black38,
                      type: MaterialType.card,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            ClipOval(
                              child: InkWell(
                                onTap: model.showJourneyControls
                                    ? model.updateJourneyStatus
                                    : null,
                                child: model.isBusy
                                    ? SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: kColorMiniDarkBlue,
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Material(
                                          color: Colors.white,
                                          elevation: 5,
                                          child: model.journeyStatus == null
                                              ? Container()
                                              : model.journeyStatus
                                                      .toLowerCase()
                                                      .contains('scheduled')
                                                  ? Icon(
                                                      Icons.play_arrow,
                                                      color: kStartControl,
                                                    )
                                                  : model.journeyStatus
                                                          .toLowerCase()
                                                          .contains('completed')
                                                      ? Icon(
                                                          Icons.check,
                                                          color: kStartControl,
                                                        )
                                                      : Icon(
                                                          Icons.stop,
                                                          color: kStopControl,
                                                        ),
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  model.currentJourney != null
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              model.currentJourney?.journeyId,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              model.journeyStatus.toUpperCase(),
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${model.currentJourney.route}'
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        'STOPS : ${model.deliveryStops}',
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
//                                        Text(
//                                          '${model.completionStatus}%',
//                                          style: TextStyle(
//                                            color: Colors.black54,
//                                          ),
//                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRect(
                                  child: InkWell(
                                    onTap: () async {
                                      await showModalBottomSheet(
                                        context: (context),
                                        builder: (context) => Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.close),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.read_more),
                                                title: Text(
                                                    'Return Crates To Warehouse'),
                                                onTap: () async {
                                                  await model
                                                      .navigateToCrateView();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                leading:
                                                    Icon(Icons.location_on),
                                                title: Text('Show Journey Map'),
                                                onTap: () async {
                                                  await model
                                                      .navigateToJourneyMap();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                onTap: () async {
                                                  await model
                                                      .navigateToJourneyInfoRoute();
                                                  Navigator.pop(context);
                                                },
                                                leading: Icon(Icons.swap_calls),
                                                title:
                                                    Text('View other journeys'),
                                              ),
                                              //@TODO: Activate deselect
                                              // ListTile(
                                              //   leading:
                                              //       Icon(Icons.swap_calls),
                                              //   title:
                                              //       Text('Deselect Journey'),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.expand_more,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        viewModelBuilder: () => JourneyConsoleViewModel());
  }
}
