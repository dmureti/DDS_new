import 'package:distributor/ui/widgets/smart_widgets/control/switch_control/switch_control_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:stacked/stacked.dart';

/// This controls the switching of journeys
class SwitchControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SwitchControlViewModel>.reactive(
        builder: (context, model, child) => IconButton(
              onPressed: () async {
                await model.navigateToJourneyInfoRoute();
              },
              icon: Icon(
                AntDesign.switcher,
                color: Colors.white,
              ),
              tooltip: 'Switch Journeys',
            ),
        viewModelBuilder: () => SwitchControlViewModel());
  }
}
