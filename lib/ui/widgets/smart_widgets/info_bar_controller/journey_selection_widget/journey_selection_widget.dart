import 'package:distributor/core/models/delivery_journey.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar_controller/journey_selection_widget/journey_selection_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// Used to show the number of [DeliveryJourney] a [User] has.
/// This is displayed if the user has a list of [DeliveryJourney] and the user has not selected a [LogisticsService.currentJourney]
class JourneySelectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneySelectionWidgetViewModel>.reactive(
        builder: (context, model, child) => Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFFe31f22),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Color(0xFFe31f22),
                  type: MaterialType.card,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(5),
                  borderOnForeground: true,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              model.navigateToJourneyInfoRoute();
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'You have ${model.numberOfJourneys} journeys to complete today. Tap to view the journey information',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 17),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: AnimatedContainer(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green.withOpacity(0)),
                                    child: Container(
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                    ),
                                    duration: Duration(seconds: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => JourneySelectionWidgetViewModel());
  }
}
