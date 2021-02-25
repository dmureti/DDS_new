import 'package:distributor/ui/widgets/reactive/map_icon_button/map_iconbutton_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:stacked/stacked.dart';

class MapIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapIconButtonViewModel>.reactive(
        builder: (context, model, child) => IconButton(
              onPressed: model.onTrip == true
                  ? () async {
                      model.navigateToJourneyMapView();
                    }
                  : null,
              icon: Icon(Entypo.direction),
            ),
        viewModelBuilder: () => MapIconButtonViewModel());
  }
}
