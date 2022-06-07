import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:distributor/ui/shared/text_styles.dart';
import 'package:distributor/ui/views/journey/journey_view_viewmodel.dart';
import 'package:distributor/ui/widgets/reactive/journey_console/journey_console.dart';
import 'package:distributor/ui/widgets/smart_widgets/control/select_control/select_control_widget.dart';

import 'package:distributor/ui/widgets/smart_widgets/stops_widget/stops_list_widget.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:tripletriocore/tripletriocore.dart';

class JourneyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneyViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Today\'s Journeys'),
              ),
              body: Column(
                children: [
                  model.selectedJourney.journeyId == null
                      ? Container(
                          height: 0,
                        )
                      : JourneyConsole(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.userJourneyList.length,
                      itemBuilder: (context, index) =>
                          DeliveryJourneyExpansionPanel(
                        deliveryJourney: model.userJourneyList[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => JourneyViewModel());
  }
}

class DeliveryJourneyExpansionPanel
    extends HookViewModelWidget<JourneyViewModel> {
  final DeliveryJourney deliveryJourney;
  DeliveryJourneyExpansionPanel(
      {@required this.deliveryJourney, Key key, reactive: true})
      : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, JourneyViewModel model) {
    return ViewModelBuilder<JourneyViewModel>.reactive(
        builder: (context, model, child) => Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Material(
                type: MaterialType.card,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 0,
                child: ExpansionTile(
                  backgroundColor: kLightestBlue,
                  initiallyExpanded: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(deliveryJourney.journeyId,
                          style: kJourneyIdTextStyle),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          '${deliveryJourney.route}',
                          style: kRouteTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.selectedJourney.journeyId ==
                                    deliveryJourney.journeyId
                                ? model.selectedJourney.status.toUpperCase()
                                : deliveryJourney.status.toUpperCase(),
                            style: kJourneySecondaryTextStyle,
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          deliveryJourney.dependentRoutes.isNotEmpty
                              ? Text('M')
                              : Text(deliveryJourney.dependentRoutes.length
                                  .toString()),
                          model.selectedJourney.journeyId ==
                                  deliveryJourney.journeyId
                              ? Icon(Icons.star)
                              : Container(
                                  width: 0,
                                )
                        ],
                      ),
                    ],
                  ),
                  children: [
                    Container(
                      height: 2,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    StopsListWidget(
                      deliveryJourney: deliveryJourney,
                    ),
                    // Journey control widget
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: SelectControlWidget(
                        deliveryJourney: deliveryJourney,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => JourneyViewModel());
  }
}
