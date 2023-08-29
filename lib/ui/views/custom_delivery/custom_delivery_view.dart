import 'package:distributor/conf/dds_brand_guide.dart';
import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/ui/views/custom_delivery/custom_delivery_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
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
          body: Column(
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
                    );
                  },
                  itemCount: model.items.length,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kColDDSPrimaryDark)),
                      onPressed: model.commit,
                      child: Text('Complete'),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kColDDSPrimaryDark)),
                      onPressed: model.commit,
                      child: Text('Complete & Print'),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
      viewModelBuilder: () => CustomDeliveryViewModel(
          customer: customer,
          deliveryNote: deliveryNote,
          deliveryStop: deliveryStop),
    );
  }
}
