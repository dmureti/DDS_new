import 'package:distributor/src/ui/views/journey_log/journey_log_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class JourneyLog extends StatelessWidget {
  const JourneyLog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneyLogViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold();
      },
      viewModelBuilder: () => JourneyLogViewModel(),
    );
  }
}
