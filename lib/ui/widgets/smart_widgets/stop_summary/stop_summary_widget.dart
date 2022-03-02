import 'package:distributor/ui/widgets/smart_widgets/stop_summary/stop_summary_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StopSummaryWidget extends StatelessWidget {
  const StopSummaryWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Display the journey
    //Display the stops
    //Show the type of stop
    //Journey Id
    return ViewModelBuilder<StopSummaryViewModel>.reactive(
        builder: (context, model, child) {
          return Container();
        },
        viewModelBuilder: () => StopSummaryViewModel());
  }
}
