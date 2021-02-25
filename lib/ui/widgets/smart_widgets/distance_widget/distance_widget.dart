import 'package:distributor/ui/widgets/smart_widgets/distance_widget/distance_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class DistanceWidget extends StatelessWidget {
  final UserLocation customerLocation;
  final UserLocation userLocation;

  const DistanceWidget(this.customerLocation, this.userLocation, {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DistanceWidgetViewModel>.reactive(
        builder: (context, model, child) => Container(
              child: model.isBusy
                  ? Container()
                  : Text(
                      '${model.data.toStringAsFixed(0)} km away',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
        viewModelBuilder: () =>
            DistanceWidgetViewModel(customerLocation, userLocation));
  }
}

//class DistanceDisplay extends HookViewModelWidget<DistanceWidgetViewModel> {
//  @override
//  Widget buildViewModelWidget(
//      BuildContext context, DistanceWidgetViewModel model) {
//    return FutureBuilder<double>(
//        future: model.getDistance(model.data),
//        builder: (context, AsyncSnapshot<double> snapshot) {
//          if (snapshot.connectionState == ConnectionState.waiting) {
//            return Container();
//          } else
//            return Text('${snapshot.data.toStringAsFixed(0)} km');
//        });
//  }
//}
