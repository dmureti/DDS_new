import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:distributor/ui/views/delivery_note/delivery_note_viewmodel.dart';
import 'package:tripletriocore/tripletriocore.dart';

class DeliveryNoteView extends StatelessWidget {
  final SalesOrder salesOrder;
  final DeliveryStop deliveryStop;

  const DeliveryNoteView(
      {Key key, this.salesOrder, @required this.deliveryStop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeliveryNoteViewmodel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Container(
            child: model.isBusy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : model.deliveryNotes.length == 0
                    ? Center(
                        child: Text(
                            'Could not find any associated delivery notes'))
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          DeliveryNote d = model.deliveryNotes[index];
                          return OrderListTile(
                            orderNo: d.deliveryNoteId,
                            orderStatus: d.deliveryStatus,
                            deliveryType: d.deliveryType,
                            date: d.deliveryDate,
                            items: d.deliveryItems,
                            onTap: () {},
                          );
                        },
                        itemCount: model.deliveryNotes.length,
                      ),
          );
        },
        viewModelBuilder: () => DeliveryNoteViewmodel(salesOrder));
  }
}
