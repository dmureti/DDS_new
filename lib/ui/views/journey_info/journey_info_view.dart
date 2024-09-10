import 'package:distributor/ui/views/journey_info/journey_info_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class JourneyInfoView extends StatelessWidget {
  const JourneyInfoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneyInfoViewModel>.reactive(
      builder: (BuildContext, model, Widget) {
        return Scaffold(
          body: model.isBusy ? BusyWidget() : Container(),
          appBar: AppBar(),
        );
      },
      viewModelBuilder: () => JourneyInfoViewModel(),
    );
  }
}
