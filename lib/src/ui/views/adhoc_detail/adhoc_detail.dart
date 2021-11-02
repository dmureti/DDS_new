import 'package:distributor/src/ui/views/adhoc_detail/adhoc_detail_viewmodel.dart';
import 'package:distributor/ui/shared/widgets.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AdhocDetailView extends StatelessWidget {
  final String referenceNo;
  const AdhocDetailView({Key key, @required this.referenceNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdhocDetailViewModel>.reactive(
        onModelReady: (model) => model.getAdhocDetail(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(referenceNo),
              actions: [
                PopupMenuButton(
                    onSelected: (x) {
                      // model.navigateToPage(x);
                    },
                    itemBuilder: (context) => <PopupMenuEntry<Object>>[
                          PopupMenuItem(
                            child: Text(
                              'Edit Adhoc Sale',
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 'edit_adhoc_sale',
                          ),
                          PopupMenuItem(
                            child: Text(
                              'Reverse Adhoc Sale',
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 'reverse_adhoc_sale',
                          ),
                          PopupMenuDivider(),
                          PopupMenuItem(
                            child: Text(
                              'Cancel Adhoc Sale',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            value: 'cancel',
                          ),
                        ]),
              ],
            ),
            body: GenericContainer(
              child: !model.fetched
                  ? Center(child: BusyWidget())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${model.adhocDetail.deliveryStatus.toUpperCase()}'),
                        ReportFieldRow(
                            field: 'Delivery Date',
                            value: model.adhocDetail.deliveryDate),
                        ReportFieldRow(
                            field: 'Customer Name',
                            value: model.adhocDetail.customerName),
                        ReportFieldRow(
                            field: 'Delivery Note Id',
                            value: model.adhocDetail.deliveryNoteId),
                        ReportFieldRow(
                            field: 'Delivery Type',
                            value: model.adhocDetail.deliveryType),
                        ReportFieldRow(
                            field: 'Delivery Warehouse',
                            value: model.adhocDetail.deliveryWarehouse),
                        ReportFieldRow(
                            field: 'Total',
                            value:
                                'Kshs ${model.adhocDetail.total.toStringAsFixed(2)}'),
                        Divider(),
                        Row(
                          children: [
                            Text('Delivery Items'.toUpperCase()),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit),
                            ),
                          ],
                        ),
                        model.adhocDetail.deliveryItems != null
                            ? Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      DeliveryItem deliveryItem =
                                          DeliveryItem.fromMap(model.adhocDetail
                                              .deliveryItems[index]);
                                      return buildDeliveryItemContainer(
                                          deliveryItem);
                                    },
                                    separatorBuilder: (context, int) {
                                      return Divider(
                                        height: 1,
                                      );
                                    },
                                    itemCount:
                                        model.adhocDetail.deliveryItems.length),
                              )
                            : Container()
                      ],
                    ),
            ),
          );
        },
        viewModelBuilder: () => AdhocDetailViewModel(referenceNo));
  }

  buildDeliveryItemContainer(DeliveryItem deliveryItem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${deliveryItem.itemCode}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  '${deliveryItem.quantity}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  // textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          title: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${deliveryItem.itemName}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text('Delivered : ${deliveryItem.quantity}'),
                  ],
                ),
              ],
            ),
          ),
          trailing: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  deliveryItem.itemRate.toStringAsFixed(2),
                  // textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
