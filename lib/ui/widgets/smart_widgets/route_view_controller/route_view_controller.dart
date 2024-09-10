import 'package:distributor/ui/widgets/dumb_widgets/no_journey_container.dart';
import 'package:distributor/ui/widgets/smart_widgets/journey_list_widget/journey_list_widget.dart';
import 'package:distributor/ui/widgets/smart_widgets/route_view_controller/route_view_controller_viewmodel.dart';
import 'package:distributor/ui/widgets/smart_widgets/stops_widget/stops_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RouteViewController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteViewControllerViewModel>.reactive(
        builder: (context, model, child) => model.userHasJourneys
            ? model.currentJourney.journeyId == null
                ? JourneyListWidget()
                : Expanded(
                    child: StopsListWidget(
                      deliveryJourney: model.currentJourney,
                    ),
                  )
            : NoJourneyContainer(),
        viewModelBuilder: () => RouteViewControllerViewModel());
  }
}
