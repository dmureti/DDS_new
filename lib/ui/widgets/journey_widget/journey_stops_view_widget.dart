import 'package:distributor/ui/widgets/journey_widget/journey_stops_view_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class JourneyStopsViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, model, child) => Container(),
        viewModelBuilder: () => JourneyStopsViewWidgetViewModel());
  }
}
