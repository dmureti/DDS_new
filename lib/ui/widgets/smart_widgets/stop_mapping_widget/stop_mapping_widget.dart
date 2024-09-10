import 'package:distributor/ui/widgets/smart_widgets/stop_mapping_widget/stop_mapping_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StopMappingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StopMappingWidgetViewModel>.reactive(
        builder: (context, model, child) => Container(),
        viewModelBuilder: () => StopMappingWidgetViewModel());
  }
}
