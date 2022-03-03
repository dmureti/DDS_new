import 'package:distributor/core/helper.dart';
import 'package:distributor/src/ui/text_styles.dart';

import 'package:distributor/src/ui/views/adhoc_cart_view/adhoc_cart_viewmodel.dart';
import 'package:distributor/ui/views/orders/create_order/sales_order_view_model.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
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
                  ? Center(child: BusyWidget())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isWalkin
                            ? Container()
                            : Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Available Credit : Kshs ${Helper.formatCurrency(customer.creditLimit - model.total)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: (customer.creditLimit -
                                                      model.total)
                                                  .isNegative
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              Product product =
                                  model.customerProductList[index];
                              return ViewModelBuilder<
                                      SalesOrderViewModel>.reactive(
                                  builder:
                                      (context, salesOrderViewModel, child) {
                                    return model.checkIfStockExists(product)
                                        ? SalesOrderItemWidget(
                                            quantity: model.stockBalanceList
                                                .firstWhere(
                                                    (element) =>
                                                        element.itemCode ==
                                                        product.itemCode,
                                                    orElse: () =>
                                                        Product(quantity: 0))
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
                            itemCount: model.customerProductList.length,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            child: Text(
                              'CONTINUE TO PAYMENT',
                              style: kActiveButtonTextStyle,
                            ),
                            onPressed: model.customer.creditLimit.isNegative ||
                                    model.total == 0
                                ? null
                                : model.total > model.customer.creditLimit
                                    ? () =>
                                        model.displayCreditLimitExceedDialog()
                                    : () {
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
