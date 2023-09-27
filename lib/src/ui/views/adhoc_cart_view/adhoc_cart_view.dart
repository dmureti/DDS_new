import 'package:distributor/ui/views/orders/create_order/sales_order_view_model.dart';
import 'package:distributor/ui/widgets/action_button.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:distributor/ui/widgets/smart_widgets/sales_order_item/sales_order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AdhocCartView extends StatelessWidget {
  final Customer customer;
  final bool isWalkin;

  const AdhocCartView({Key key, this.customer, this.isWalkin})
      : super(key: key);
  @override
  // Widget build(BuildContext context) {
  //   return ViewModelBuilder<AdhocCartViewModel>.reactive(
  //       onModelReady: (model) => model.init(),
  //       builder: (context, model, child) {
  //         return Scaffold(
  //           appBar: AppBar(
  //             title: Text('Cart'),
  //           ),
  //           body: Container(
  //             child: model.customerProductList == null
  //                 ? Center(child: BusyWidget())
  //                 : Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       if (model.enforceCreditLimit)
  //                         Container(
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(
  //                                 horizontal: 12.0, vertical: 10),
  //                             child: Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 if (model.enforceCreditLimit)
  //                                   Expanded(
  //                                     child: Text(
  //                                       'Available Credit : ${Helper.formatCurrency(model.creditLimit)}',
  //                                       style: TextStyle(
  //                                         fontWeight: FontWeight.w500,
  //                                         color:
  //                                             (model.total > model.creditLimit)
  //                                                 ? Colors.red
  //                                                 : Colors.green,
  //                                       ),
  //                                       textAlign: TextAlign.left,
  //                                     ),
  //                                   ),
  //                                 if (model.enforceCustomerSecurity)
  //                                   Text(
  //                                     'Security : ${Helper.formatCurrency(model.securityBalance)}',
  //                                     style: TextStyle(
  //                                       fontWeight: FontWeight.w500,
  //                                       color: (model.total > model.creditLimit)
  //                                           ? Colors.red
  //                                           : Colors.green,
  //                                     ),
  //                                     textAlign: TextAlign.left,
  //                                   ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       model.shopHasStock
  //                           ? Expanded(
  //                               child: ListView.builder(
  //                                 itemBuilder: (context, index) {
  //                                   Product product =
  //                                       model.customerProductList[index];
  //                                   return ViewModelBuilder<
  //                                           SalesOrderViewModel>.reactive(
  //                                       builder: (context, salesOrderViewModel,
  //                                           child) {
  //                                         return model
  //                                                 .checkIfStockExists(product)
  //                                             ? SalesOrderItemWidget(
  //                                                 quantity: model
  //                                                     .stockBalanceList
  //                                                     .firstWhere(
  //                                                         (element) =>
  //                                                             element
  //                                                                 .itemCode ==
  //                                                             product.itemCode,
  //                                                         orElse: () => Product(
  //                                                             quantity: 0))
  //                                                     .quantity,
  //                                                 item:
  //                                                     model.customerProductList[
  //                                                         index],
  //                                                 salesOrderViewModel:
  //                                                     salesOrderViewModel)
  //                                             : Container();
  //                                       },
  //                                       viewModelBuilder: () =>
  //                                           SalesOrderViewModel(
  //                                               customer: model.customer));
  //                                 },
  //                                 itemCount: model.customerProductList.length,
  //                               ),
  //                             )
  //                           : Expanded(
  //                               child: Center(
  //                                 child: EmptyContentContainer(
  //                                     label: 'You have no stock.'),
  //                               ),
  //                             ),
  //                       if (model.shopHasStock && model.customerHasProducts)
  //                         ActionButton(
  //                           label: 'Continue to Payment',
  //                           onPressed: model.submitStatus
  //                               ? model.navigateToAdhocPaymentView
  //                               : null,
  //                         ),
  //                     ],
  //                   ),
  //           ),
  //         );
  //       },
  //       viewModelBuilder: () =>
  //           AdhocCartViewModel(isWalkin: isWalkin, customer: customer));
  // }

  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesOrderViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronLeft),
            onPressed: () async {
              Navigator.pop(context, false);
            },
          ),
          title: AppBarColumnTitle(
            mainTitle: 'Cart',
            subTitle: isWalkin ? model.customerName : customer.name,
          ),
        ),
        body: model.isBusy
            ? Center(
                child: BusyWidget(),
              )
            : model.productList.isEmpty
                ? Center(
                    child: EmptyContentContainer(label: 'No SKUs found'),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: <Widget>[_ResultsView()],
                        ),
                      ),
                      ActionButton(
                          label: 'Continue to Payment',
                          onPressed: () => model.navigateToAdhocPaymentView()),
                    ],
                  ),
      ),
      viewModelBuilder: () =>
          SalesOrderViewModel(customer: customer, isWalkIn: isWalkin),
      onModelReady: (model) => model.initializeAdhoc(),
    );
  }
}

class _ResultsView extends HookViewModelWidget<SalesOrderViewModel> {
  _ResultsView();
  @override
  Widget buildViewModelWidget(BuildContext context, SalesOrderViewModel model) {
    return ListView.separated(
        physics: ClampingScrollPhysics(),
        separatorBuilder: (context, index) {
          return Divider(
            height: 0.1,
          );
        },
        shrinkWrap: true,
        itemCount: model.productList.length,
        itemBuilder: (context, index) {
          Product product = model.productList[index];
          return SalesOrderItemWidget(
            item: product,
            salesOrderViewModel: model,
            // quantity: model.getQuantity(product),
          );
        });
  }
}
