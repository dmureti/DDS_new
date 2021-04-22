import 'package:distributor/ui/shared/text_styles.dart';

import 'package:distributor/ui/widgets/smart_widgets/stops_widget/stop_list_tile/stop_list_tile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StopListTile extends StatelessWidget {
  final String salesOrderId;
  final DeliveryJourney deliveryJourney;
  final DeliveryStop deliveryStop;
  const StopListTile(
      {@required this.salesOrderId,
      @required this.deliveryJourney,
      @required this.deliveryStop,
      Key key})
      : assert(salesOrderId != null, deliveryJourney != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StopListTileViewModel>.reactive(
      viewModelBuilder: () => StopListTileViewModel(deliveryJourney.journeyId,
          salesOrderId: salesOrderId),
      builder: (context, model, child) => model.isBusy
          ? CircularProgressIndicator()
          : model.hasError
              ? Text(model.error.toString())
              : Container(
                  margin: EdgeInsets.all(8),
                  child: Material(
                    type: MaterialType.card,
                    elevation: 1,
                    child: ListTile(
                      onTap: () async {
                        await model.navigateToDeliveryDetailView(
                            deliveryJourney, deliveryStop);
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            deliveryStop.deliveryNoteId,
                            style: kSalesOrderIdTextStyle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              deliveryStop.customerId,
                              style: kCustomerNameTextStyle,
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${model.salesOrder.orderStatus}'),
                          Spacer(),

//                          Text(
//                            'kms away',
//                            style: kStopSecondaryTextStyle,
//                          ),
                        ],
                      ),
//                      trailing: model.salesOrder.orderStatus
//                              .toLowerCase()
//                              .contains('to bill')
//                          ? Icon(Icons.check)
//                          : Icon(Icons.timer),
                    ),
                  ),
                ),
    );
  }
}
