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
      : assert(salesOrderId != null, deliveryStop != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StopListTileViewModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => StopListTileViewModel(deliveryJourney.journeyId,
          salesOrderId: salesOrderId, deliveryStop: deliveryStop),
      builder: (context, model, child) => model.deliveryNote == null
          ? CircularProgressIndicator()
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
                        model.deliveryStop.deliveryNoteId,
                        style: kSalesOrderIdTextStyle,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          model.deliveryStop.customerId,
                          style: kCustomerNameTextStyle,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${model.deliveryNote.deliveryStatus}'),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
