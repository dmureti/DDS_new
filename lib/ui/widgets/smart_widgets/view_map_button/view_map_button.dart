import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:distributor/ui/widgets/smart_widgets/view_map_button/view_map_button_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

class ViewMapButton extends StatelessWidget {
  final String deliveryJourneyId;

  ViewMapButton({this.deliveryJourneyId, Key key})
      : assert(deliveryJourneyId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewMapButtonViewModel>.reactive(
        onModelReady: (model) => model.getJourneyDetails(),
        builder: (context, model, child) => ClipOval(
              child: Material(
                color: kLightestBlue,
                elevation: 10,
                shadowColor: Colors.black12,
                child: InkWell(
                  splashColor: Colors.pink,
                  onTap: model.deliveryJourney != null
                      ? model.navigateToViewMap
                      : null,
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.black38,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => ViewMapButtonViewModel(deliveryJourneyId));
  }
}
