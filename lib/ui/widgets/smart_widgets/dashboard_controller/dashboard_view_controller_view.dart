import 'package:distributor/ui/widgets/dumb_widgets/dashboard_journey_container.dart';
import 'package:distributor/ui/widgets/dumb_widgets/no_journey_container.dart';
import 'package:distributor/ui/widgets/smart_widgets/dashboard_controller/dashboard_view_controller_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

// Will manage the display for the dashboard
class DashboardViewControllerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewControllerViewModel>.reactive(
        builder: (context, model, child) => model.userHasJourneys == false
            ? NoJourneyContainer()
            : DashboardJourneyContainer(),
        viewModelBuilder: () => DashboardViewControllerViewModel());
  }
}
