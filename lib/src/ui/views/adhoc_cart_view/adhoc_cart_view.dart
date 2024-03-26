import 'package:distributor/core/helper.dart';
import 'package:distributor/ui/views/orders/create_order/sales_order_view_model.dart';
import 'package:distributor/ui/widgets/action_button.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:distributor/ui/widgets/smart_widgets/sales_order_item/sales_order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
                      // if (isWalkin)
                      //   Container()
                      // else
                      //   Container(
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 12.0, vertical: 10),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Expanded(
                      //             child: Text(
                      //               'Available Credit : Kshs ${Helper.formatCurrency(model.creditLimit - (model.total))}',
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.w500,
                      //                 color: ((model.creditLimit -
                      //                             (model.total +
                      //                                 model.securityBalance)) >=
                      //                         0)
                      //                     ? Colors.green
                      //                     : Colors.red,
                      //               ),
                      //               textAlign: TextAlign.left,
                      //             ),
                      //           ),
                      //           Text(
                      //             model.isVariable
                      //                 ? 'Security : Kshs ${Helper.formatCurrency(model.securityBalance - model.securityAmount)} '
                      //                 : 'Security : Kshs ${model.securityAmount}',
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.w500,
                      //               color: (model.total > model.creditLimit)
                      //                   ? Colors.red
                      //                   : Colors.green,
                      //             ),
                      //             textAlign: TextAlign.left,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      SearchBar(),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: <Widget>[_ResultsView()],
                        ),
                      ),
                      ActionButton(
                        label: 'Continue to Payment',
                        onPressed: model.cartHasItems
                            // ? () => model.navigateToAdhocPaymentView()n
                            ? () => model.navigateToPaymentView()
                            : null,
                      )
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
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: model.productList.length,
        itemBuilder: (context, index) {
          Product product = model.productList[index];
          //Check if the user has this item in stock
          if (model.checkIfStockExists(product)) {
            return SalesOrderItemWidget(
              item: product,
              salesOrderViewModel: model,
              quantity: model.getQuantity(product),
            );
          } else {
            return Container(height: 0);
          }
        });
  }
}

class SearchBar extends HookViewModelWidget<SalesOrderViewModel> {
  @override
  Widget buildViewModelWidget(
      BuildContext context, SalesOrderViewModel viewModel) {
    var searchString =
        useTextEditingController(text: viewModel.skuSearchString);
    return TextFormField(
      controller: searchString,
      keyboardType: TextInputType.text,
      // textInputAction: TextInputAction.en,
      onChanged: viewModel.updateSearchString,
      // onTap: () => viewModel.toggleShowSummary(false),
      // onFieldSubmitted: (val) => viewModel.onFieldSubmitted(val),
      onEditingComplete: () {
        //Happens when the user presses the action
        // viewModel.onEditComplete();
        //Close the keyboard
      },
      decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          // hintText: 'Search for an SKU',
          suffixIcon: IconButton(
              onPressed: () {
                searchString.text = '';
                viewModel.resetSearch();
              },
              icon: Icon(Icons.cancel_outlined))),
    );
  }
}
