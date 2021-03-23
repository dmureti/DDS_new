import 'package:distributor/src/ui/views/partial_delivery/partial_delivery_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:tripletriocore/tripletriocore.dart';

class PartialDeliveryView extends StatelessWidget {
  final SalesOrder salesOrder;
  final DeliveryJourney deliveryJourney;
  final String stopId;

  const PartialDeliveryView(
      {Key key, this.salesOrder, this.deliveryJourney, this.stopId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PartialDeliveryViewModel>.nonReactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Partial Delivery'),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        SalesOrderRequestItem salesOrderRequestItem =
                            model.orderItems[index];

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Material(
                            type: MaterialType.card,
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        salesOrderRequestItem.itemCode,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        salesOrderRequestItem.quantity
                                            .toStringAsFixed(0),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              salesOrderRequestItem.itemName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Delivered ${salesOrderRequestItem.quantityDelivered.toStringAsFixed(0)}',
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              '${salesOrderRequestItem.lineAmount.toStringAsFixed(2)}',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: UnitsDeliveredTextForm(
                                          salesOrderRequestItem, index))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: model.orderItems.length,
                    ),
                  ),
                  Container(
                    height: 50,
                    child: model.isBusy
                        ? Center(
                            child: BusyWidget(),
                          )
                        : RaisedButton(
                            child: Text('Make Delivery'),
                            onPressed: () {
                              model.makePartialDelivery();
                            },
                          ),
                  )
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () =>
            PartialDeliveryViewModel(salesOrder, deliveryJourney, stopId));
  }
}

class UnitsDeliveredTextForm
    extends HookViewModelWidget<PartialDeliveryViewModel> {
  final SalesOrderRequestItem salesOrderRequestItem;
  final int index;

  UnitsDeliveredTextForm(this.salesOrderRequestItem, this.index);
  @override
  Widget buildViewModelWidget(
      BuildContext context, PartialDeliveryViewModel model) {
    num toDeliver = salesOrderRequestItem.quantity -
        salesOrderRequestItem.quantityDelivered;
    return TextFormField(
      initialValue: toDeliver.toString(),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        model.updateSalesOrderRequestItem(index, value);
      },
    );
  }
}
