import 'package:distributor/ui/widgets/smart_widgets/stops_widget/stop_list_tile/stop_list_tile.dart';
import 'package:distributor/ui/widgets/smart_widgets/stops_widget/stops_list_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StopsListWidget extends StatelessWidget {
  final DeliveryJourney deliveryJourney;

  const StopsListWidget({this.deliveryJourney, Key key})
      : assert(deliveryJourney != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StopsListWidgetViewModel>.reactive(
        onModelReady: (model) => model.getJourneyDetails(),
        builder: (context, model, child) => model.deliveryJourney == null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: model.deliveryJourney.stops
                    .map((DeliveryStop deliveryStop) {
                  if (deliveryStop.orderId.length != 0) {
                    return StopListTile(
                      salesOrderId: deliveryStop.orderId,
                      deliveryJourney: deliveryJourney,
                      deliveryStop: deliveryStop,
                    );
                  } else {
                    return Container();
                  }
                }).toList()),
        viewModelBuilder: () =>
            StopsListWidgetViewModel(journeyId: deliveryJourney.journeyId));
  }
}
