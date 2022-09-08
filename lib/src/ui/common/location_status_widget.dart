import 'package:distributor/src/ui/common/location_status_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LocationStatusWidget extends StatelessWidget {
  const LocationStatusWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocationStatusViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) =>
          model.isLocationActive ? Container() : model.displayDialog(),
      viewModelBuilder: () => LocationStatusViewModel(),
    );
  }
}
