import 'package:distributor/ui/views/orders/sales_order_item_list/sales_order_item_list_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/sales_order_item_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class SalesOrderItemList extends StatelessWidget {
  final String salesOrderId;
  const SalesOrderItemList({this.salesOrderId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesOrderItemListViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => model.isBusy
            ? Center(
                child: BusyWidget(),
              )
            : Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.salesOrderRequestItems.length,
                  itemBuilder: (context, index) {
                    SalesOrderRequestItem salesOrderRequestItem =
                        model.salesOrderRequestItems[index];
                    return SalesOrderRequestItemWidget(salesOrderRequestItem);
                  },
                ),
              ),
        viewModelBuilder: () =>
            SalesOrderItemListViewModel(salesOrderId: salesOrderId));
  }
}
