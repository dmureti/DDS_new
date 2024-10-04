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

class AdhocCartView extends StatefulWidget {
  final Customer customer;
  final bool isWalkin;

  const AdhocCartView({Key key, this.customer, this.isWalkin})
      : super(key: key);

  @override
  _AdhocCartViewState createState() => _AdhocCartViewState();
}

class _AdhocCartViewState extends State<AdhocCartView> {
  bool isDelayCompleted = false;

  @override
  void initState() {
    super.initState();

    // Introduce a 2.5-second delay
    Future.delayed(const Duration(milliseconds: 2800), () {
      setState(() {
        isDelayCompleted = true; // Update the state after the delay
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesOrderViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.chevronLeft),
            onPressed: () async {
              Navigator.pop(context, false);
            },
          ),
          title: AppBarColumnTitle(
            mainTitle: 'Cart',
            subTitle:
                widget.isWalkin ? model.customerName : widget.customer.name,
          ),
        ),
        body: model.isBusy
            ? const Center(
                child: BusyWidget(),
              )
            : !isDelayCompleted
                ? const Center(
                    child:
                        BusyWidget(), // Show BusyWidget until the delay is done
                  )
                : model.productList.isEmpty
                    ? const Center(
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
                            onPressed: model.cartHasItems
                                ? () => model.navigateToAdhocPaymentView()
                                : null,
                          ),
                        ],
                      ),
      ),
      viewModelBuilder: () => SalesOrderViewModel(
          customer: widget.customer, isWalkIn: widget.isWalkin),
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
          //Check if the user has this item in stock
          if (model.checkIfStockExists(product)) {
            return SalesOrderItemWidget(
              item: product,
              salesOrderViewModel: model,
              initialQuantity: model.getQuantity(product),
            );
          } else {
            return Container(height: 0);
          }
        });
  }
}
