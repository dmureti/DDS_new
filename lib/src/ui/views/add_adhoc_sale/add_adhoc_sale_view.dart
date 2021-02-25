import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:distributor/ui/widgets/smart_widgets/sales_order_item/sales_order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

import './add_adhoc_sale_view_model.dart';

class AddAdhocSaleView extends StatelessWidget {
  final Customer customer;

  const AddAdhocSaleView({Key key, this.customer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddAdhocSaleViewModel>.reactive(
      onModelReady: (model) => model.fetchStockBalance(),
      viewModelBuilder: () => AddAdhocSaleViewModel(customer),
      builder: (
        BuildContext context,
        AddAdhocSaleViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: AppBarColumnTitle(
              mainTitle: 'Adhoc Sale',
              subTitle: model.customer == null
                  ? 'Walk-In Customer'
                  : model.customer.name,
            ),
          ),
          body: model.productList == null
              ? BusyWidget()
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return SalesOrderItemWidget(
                        item: model.productList[index],
                        salesOrderViewModel: null);
                  },
                  itemCount: model.productList.length,
                ),
        );
      },
    );
  }
}
