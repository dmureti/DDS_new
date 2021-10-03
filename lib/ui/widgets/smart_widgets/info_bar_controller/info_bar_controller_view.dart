import 'package:distributor/ui/widgets/reactive/journey_console/journey_console.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar_controller/info_bar_controller_viewmodel.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar_controller/journey_selection_widget/journey_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class InfoBarController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InfoBarControllerViewModel>.reactive(
        builder: (context, model, child) => model.userHasJourneys
            ? model.hasSelectedJourney
                //Use has selected a journey
//                ? JourneyControllerWidget()
                ? JourneyConsole()
                // User has not selected a journey
                : JourneySelectionWidget()
//                : JourneyConsole()
            : Container(), //            : JourneyInfo(),
        viewModelBuilder: () => InfoBarControllerViewModel());
  }
}
