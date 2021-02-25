import 'package:distributor/core/helper.dart';
import 'package:distributor/ui/widgets/smart_widgets/control/switch_control/switch_control.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar/info_bar_widget_viewmodel.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar_controller/journey_controller_widget/journey_controller_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class JourneyControllerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneyControllerWidgetViewModel>.reactive(
        builder: (context, model, child) => Container(
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Colors.pink,
                  type: MaterialType.card,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(5),
                  borderOnForeground: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  model.currentJourney.journeyId,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w900),
                                ),

                                /// Manages the
                                SwitchControl(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                model.deliveryJourneyComplete == false
                                    ? Text(model.tripState)
                                    : Text('Completed'),
                              ],
                            ),
                            Text('Route : ' + model.currentJourney.route),
                            Text('Vehicle : ' +
                                Helper.formatRegistration(
                                    model.currentJourney.vehicle)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: Colors.white,
                                  type: MaterialType.button,
                                  borderRadius: BorderRadius.circular(4),
                                  elevation: 2,
                                  child: model.isBusy
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : model.deliveryJourneyComplete == false
                                          ? IconButton(
                                              onPressed:
                                                  model.enableControls == true
                                                      ? () async {
                                                          await model
                                                              .updateJourneyState();
                                                        }
                                                      : null,
                                              icon: model.journeyState ==
                                                      JourneyState.idle
                                                  ? Icon(
                                                      Icons.play_arrow,
                                                      color: Colors.green,
                                                    )
                                                  : Icon(
                                                      Icons.stop,
                                                      color: Colors.red,
                                                    ),
                                            )
                                          : Container(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => JourneyControllerWidgetViewModel());
  }
}
