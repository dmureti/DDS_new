import 'package:distributor/ui/widgets/smart_widgets/placemark_widget/placemark_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class PlaceMarkWidget extends StatelessWidget {
  final UserLocation userLocation;
  const PlaceMarkWidget(this.userLocation, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlacemarkWidgetViewModel>.reactive(
        builder: (context, model, child) => Container(
              child: model.isBusy
                  ? Container()
                  : Text(model.data[0].administrativeArea),
            ),
        viewModelBuilder: () => PlacemarkWidgetViewModel(userLocation));
  }
}
