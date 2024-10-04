import 'package:distributor/ui/shared/text_styles.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
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
        builder: (context, model, child) => model.isBusy
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: BusyWidget(),
                ),
              )
            : ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                // mainAxisSize: MainAxisSize.max,
                children: model.deliveryJourney.stops
                    .map((DeliveryStop deliveryStop) {
                  return _buildWidget(deliveryStop, deliveryJourney, model);
                  // return StopListTile(
                  //   salesOrderId: deliveryStop.orderId,
                  //   deliveryJourney: deliveryJourney,
                  //   deliveryStop: deliveryStop,
                  // );
                }).toList()),
        viewModelBuilder: () =>
            StopsListWidgetViewModel(journeyId: deliveryJourney.journeyId));
  }

  Widget _buildWidget(DeliveryStop deliveryStop,
      DeliveryJourney deliveryJourney, StopsListWidgetViewModel model) {
    return Stack(
      children: [
        // Main content: display the widget for the delivery stop
        deliveryStop.isTechnicalStop == 1
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Material(
                  elevation: 1,
                  child: ListTile(
                    onTap: () async {
                      // Show progress while performing async tasks
                      model.navigateToTechnicalStop(deliveryStop);
                      await model.getJourneyDetails();
                      model.notifyListeners(); // Update UI
                    },
                    subtitle: deliveryStop.isVisited == 1
                        ? const Text('Completed')
                        : const Text('Pending'),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ADDITIONAL',
                          style: kSalesOrderIdTextStyle,
                        ),
                        Text(
                          deliveryStop.stopAtBranchId,
                          style: kCustomerNameTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : deliveryStop.orderId.isNotEmpty
                ? StopListTile(
                    salesOrderId: deliveryStop.orderId,
                    deliveryJourney: deliveryJourney,
                    deliveryStop: deliveryStop,
                  )
                : Container(),

        // Show progress indicator while the data is being loaded
        if (model.isBusy)
          const Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
