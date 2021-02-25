import 'package:distributor/ui/widgets/smart_widgets/location_widget/location_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocationViewModel>.reactive(
        builder: (context, model, child) => Container(
              child: Row(
                children: [
                  Text(
                    model.data.longitude.toString(),
                  ),
                  Text(
                    model.data.latitude.toString(),
                  )
                ],
              ),
            ),
        viewModelBuilder: null);
  }
}
