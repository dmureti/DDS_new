import 'package:distributor/src/ui/views/adhoc_cart_view/adhoc_cart_viewmodel.dart';
import 'package:distributor/ui/views/orders/create_order/sales_order_view_model.dart';
import 'package:distributor/ui/widgets/smart_widgets/sales_order_item/sales_order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AdhocCartView extends StatelessWidget {
  final Customer customer;
  final bool isWalkin;

  const AdhocCartView({Key key, this.customer, this.isWalkin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdhocCartViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Cart'),
            ),
            body: Container(
              child: model.customerProductList == null
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              Product product =
                                  model.customerProductList[index];
                              return ViewModelBuilder<
                                      SalesOrderViewModel>.reactive(
                                  builder:
                                      (context, salesOrderViewModel, child) {
                                    return !model.stockBalanceList
                                            .contains(product.itemCode)
                                        ? SalesOrderItemWidget(
                                            quantity: model.stockBalanceList
                                                .firstWhere((element) =>
                                                    element.itemCode ==
                                                    product.itemCode)
                                                .quantity,
                                            item: model
                                                .customerProductList[index],
                                            salesOrderViewModel:
                                                salesOrderViewModel)
                                        : Container();
                                  },
                                  viewModelBuilder: () => SalesOrderViewModel(
                                      customer: model.customer));
                            },
                            itemCount: model.stockBalanceList.length,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            child: Text('CONTINUE TO PAYMENT'),
                            onPressed: () {
                              model.navigateToAdhocPaymentView();
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
        viewModelBuilder: () =>
            AdhocCartViewModel(isWalkin: isWalkin, customer: customer));
  }
}
