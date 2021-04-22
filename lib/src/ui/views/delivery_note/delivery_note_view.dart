import 'package:distributor/core/helper.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:distributor/ui/widgets/smart_widgets/customer_summary/customer_summary_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'delivery_note_viewmodel.dart';

class DeliveryNoteView extends StatelessWidget {
  final DeliveryJourney deliveryJourney;
  final DeliveryStop deliveryStop;
  final Customer customer;

  const DeliveryNoteView(
      {Key key, this.deliveryJourney, this.deliveryStop, this.customer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeliveryNoteViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: AppBarColumnTitle(
                  mainTitle: model.deliveryStop.customerId,
                  subTitle: model.deliveryStop.deliveryNoteId,
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'Summary',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Tab(
                        child: Text(
                      'Particulars',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                  ],
                ),
                actions: [
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return <PopupMenuEntry<Object>>[
                        PopupMenuItem(
                          child: Text('Full Delivery'),
                          value: model.deliveryStop.stopId != null
                              ? 'full_delivery'
                              : 'not_possible',
                        ),
                        PopupMenuItem(
                          child: Text('Partial Delivery'),
                          value: model.deliveryStop.stopId != null
                              ? 'partial_delivery'
                              : 'not_possible',
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          child: Text('Receive Returns'),
                          value: 'receive_return',
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          child: Text('Add Payment'),
                          value: 'add_payment',
                        ),
                      ];
                    },
                    onSelected: (x) {
                      model.handleOrderAction(x);
                    },
                  )
                ],
              ),
              body: TabBarView(
                children: [
                  model.deliveryNote == null
                      ? BusyWidget()
                      : Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                child: Material(
                                  type: MaterialType.card,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Order No : ${model.deliveryStop.deliveryNoteId}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              '${model.deliveryNote.deliveryStatus.toUpperCase()}',
                                              style: TextStyle(
                                                  color: Colors.purple,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          ],
                                        ),

                                        Divider(),

                                        Text(
                                            'Sales Order No : ${model.deliveryStop.orderId}'),
                                        Container(
                                          child: Text(
                                              'Order Date: ${Helper.getDay(deliveryJourney.deliveryDate)}'),
                                        ),
                                        Container(
                                          child: Text(
                                              'Delivery Type: ${model.deliveryNote.deliveryType}'),
                                        ),

                                        Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              // salesOrder.orderStatus
                                              //         .contains('To Bill')
                                              //     ? Text('Due Date : Delivered')
                                              //     : Text(
                                              //         'Due Date: ${Helper.getDay(salesOrder.dueDate)}')
                                            ],
                                          ),
                                        ),

                                        Text(
                                            'Branch : ${deliveryJourney.branch}'),
                                        Text(
                                            'Route : ${model.deliveryJourney.route}'),

                                        Divider(),

                                        SubheadingText('Remarks'),
                                        // Text('${model.deliveryStop.}'),

                                        Divider(),

                                        CustomerSummaryWidget(
                                            model.deliveryStop.customerId),

                                        //@TODO: Add mobile number
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  model.deliveryNote == null
                      ? BusyWidget()
                      : Container(
                          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: Material(
                            elevation: 3,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: OrderParticular(
                                    deliveryNote: model.deliveryNote,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () =>
            DeliveryNoteViewModel(deliveryJourney, deliveryStop, customer));
  }
}
