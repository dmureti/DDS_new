import 'package:distributor/conf/dds_brand_guide.dart';
import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/ui/views/custom_delivery/custom_delivery_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/quantity_input/quantity_input_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CustomDeliveryView extends StatelessWidget {
  final DeliveryNote deliveryNote;
  final DeliveryStop deliveryStop;
  final Customer customer;
  const CustomDeliveryView(
      {Key key, this.deliveryNote, this.deliveryStop, this.customer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomDeliveryViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: AppBarColumnTitle(
              mainTitle: model.deliveryStop.customerId,
              subTitle: model.deliveryStop.deliveryNoteId,
            ),
          ),
          body: model.isBusy
              ? Center(child: BusyWidget())
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          var deliveryItem = model.orderedItems[index];

                          return ListTile(
                            visualDensity: VisualDensity.compact,
                            isThreeLine: false,
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    deliveryItem['itemName'],
                                    style: kTileLeadingTextStyle,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    model.reduce(deliveryItem);
                                  },
                                  icon: Icon(Icons.remove_circle_outline),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    var result = await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return QuantityInput(
                                            title: 'Quantity to deliver'
                                                .toUpperCase(),
                                            description:
                                                "${deliveryItem['itemName']}",
                                            initialQuantity: model.getQuantity(
                                                deliveryItem['itemName']),
                                            maxQuantity:
                                                deliveryItem['orderedQty'],
                                            minQuantity: model
                                                .getMinQuantity(deliveryItem),
                                          );
                                        });
                                    if (result != null) {
                                      model.updateQuantity(
                                          deliveryItem: deliveryItem,
                                          newVal: result);
                                    }
                                  },
                                  child: Container(
                                    width: 20,
                                    child: Text(
                                      model
                                          .getQuantity(deliveryItem['itemName'])
                                          .toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      model.add(deliveryItem);
                                    },
                                    icon: Icon(Icons.add_circle_outline)),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  '${deliveryItem['itemCode']}'.toUpperCase(),
                                  style: kTileSubtitleTextStyle,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: model.items.length,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kColDDSPrimaryDark)),
                        onPressed: model.commit,
                        child: Text('Complete'),
                      ),
                    ),
                  ],
                ),
        );
      },
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => CustomDeliveryViewModel(
          customer: customer,
          deliveryNote: deliveryNote,
          deliveryStop: deliveryStop),
    );
  }
}
