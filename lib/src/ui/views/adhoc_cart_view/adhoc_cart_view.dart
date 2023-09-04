import 'package:distributor/core/helper.dart';
import 'package:distributor/src/ui/views/adhoc_cart_view/adhoc_cart_viewmodel.dart';
import 'package:distributor/ui/views/orders/create_order/sales_order_view_model.dart';
import 'package:distributor/ui/widgets/action_button.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
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
                        if (model.enforceCreditLimit)
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (model.enforceCreditLimit)
                                    Expanded(
                                      child: Text(
                                        'Available Credit : Kshs ${Helper.formatCurrency(model.creditLimit)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              (model.total > model.creditLimit)
                                                  ? Colors.red
                                                  : Colors.green,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  if (model.enforceCustomerSecurity)
                                    Text(
                                      'Security : Kshs ${Helper.formatCurrency(model.securityBalance)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: (model.total > model.creditLimit)
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        model.shopHasStock
                            ? Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    Product product =
                                        model.customerProductList[index];
                                    return ViewModelBuilder<
                                            SalesOrderViewModel>.reactive(
                                        builder: (context, salesOrderViewModel,
                                            child) {
                                          return model
                                                  .checkIfStockExists(product)
                                              ? SalesOrderItemWidget(
                                                  quantity: model
                                                      .stockBalanceList
                                                      .firstWhere(
                                                          (element) =>
                                                              element
                                                                  .itemCode ==
                                                              product.itemCode,
                                                          orElse: () => Product(
                                                              quantity: 0))
                                                      .quantity,
                                                  item:
                                                      model.customerProductList[
                                                          index],
                                                  salesOrderViewModel:
                                                      salesOrderViewModel)
                                              : Container();
                                        },
                                        viewModelBuilder: () =>
                                            SalesOrderViewModel(
                                                customer: model.customer));
                                  },
                                  itemCount: model.customerProductList.length,
                                ),
                              )
                            : Expanded(
                                child: Center(
                                  child: EmptyContentContainer(
                                      label: 'You have no stock.'),
                                ),
                              ),
                        if (model.shopHasStock && model.customerHasProducts)
                          ActionButton(
                            label: 'Continue to Payment',
                            onPressed: model.submitStatus
                                ? model.navigateToAdhocPaymentView
                                : null,
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
