import 'package:distributor/src/ui/views/partial_delivery/partial_delivery_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:tripletriocore/tripletriocore.dart';

class PartialDeliveryView extends StatelessWidget {
  final SalesOrder salesOrder;
  final DeliveryJourney deliveryJourney;
  final DeliveryNote deliveryNote;
  final DeliveryStop deliveryStop;

  const PartialDeliveryView(
      {Key key,
      this.salesOrder,
      this.deliveryJourney,
      @required this.deliveryNote,
      @required this.deliveryStop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(deliveryStop.isTechnicalStop.toString());
    return ViewModelBuilder<PartialDeliveryViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarColumnTitle(
                mainTitle: 'Partial Delivery',
                subTitle: model.deliveryStop.deliveryNoteId,
              ),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: model.userLocation == null
                  ? BusyWidget()
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              var salesOrderRequestItem =
                                  model.deliveryNote.deliveryItems[index];
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              salesOrderRequestItem['itemCode'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              salesOrderRequestItem['quantity']
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
                                                    salesOrderRequestItem[
                                                        'itemName'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              // Row(
                                              //   children: [
                                              //     Text(
                                              //       'Delivered ${salesOrderRequestItem.quantityDelivered.toStringAsFixed(0)}',
                                              //     ),
                                              //     SizedBox(
                                              //       width: 4,
                                              //     ),
                                              //     // Text(
                                              //     //   '${salesOrderRequestItem.lineAmount.toStringAsFixed(2)}',
                                              //     // ),
                                              //   ],
                                              // ),
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
                            itemCount: model.deliveryStop.deliveryItems.length,
                          ),
                        ),
                        Container(
                          height: 50,
                          child: model.isBusy
                              ? Center(
                                  child: BusyWidget(),
                                )
                              : RaisedButton(
                                  child: Text(
                                    'Make Partial Delivery',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
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
        viewModelBuilder: () => PartialDeliveryViewModel(
            salesOrder, deliveryJourney, deliveryNote, deliveryStop));
  }
}

class UnitsDeliveredTextForm
    extends HookViewModelWidget<PartialDeliveryViewModel> {
  final salesOrderRequestItem;
  final int index;

  UnitsDeliveredTextForm(this.salesOrderRequestItem, this.index);
  @override
  Widget buildViewModelWidget(
      BuildContext context, PartialDeliveryViewModel model) {
    return TextFormField(
      initialValue: salesOrderRequestItem['quantity'].toString(),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        if (value.isNotEmpty) {
          if (int.parse(value) <= salesOrderRequestItem['quantity']) {
            model.updateSalesOrderRequestItem(index, value);
          }
        }
      },
    );
  }
}
