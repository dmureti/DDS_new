import 'package:distributor/core/models/order_search_delegate.dart';
import 'package:distributor/ui/views/customers/customer_detail/order_history/order_history_view_tab_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_search.dart';
import 'package:distributor/ui/widgets/dumb_widgets/order_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class OrderHistoryTab extends StatelessWidget {
  final Customer customer;
  const OrderHistoryTab({@required this.customer, Key key})
      : assert(customer != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderHistoryTabViewModel>.reactive(
      onModelReady: (model) => model.init(),
      fireOnModelReadyOnce: false,
      disposeViewModel: true,
      builder: (context, model, child) => model.isBusy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.indigo,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      AppBarSearch(
                        delegate: OrderSearchDelegate(
                            salesOrderList: model.customerOrders,
                            deliveryJourney: null,
                            onTap: model.navigateToOrder),
                      ),
                    ],
                  ),
                ),
                model.hasError
                    ? Center(child: Text('An error occurred'))
                    : model.customerOrders.length == 0
                        ? Expanded(
                            child: Center(
                              child: Container(
                                child: Text(
                                    'This customer has not placed any orders.'),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: model.customerOrders.length,
                              itemBuilder: (context, int index) {
                                List<SalesOrder> _customerOrdersList =
                                    model.customerOrders;
                                SalesOrder salesOrder =
                                    _customerOrdersList[index];
                                DeliveryJourney deliveryJourney = null;

                                return OrderHistoryTile(model.navigateToOrder,
                                    salesOrder, deliveryJourney);
                              },
                            ),
                          ),
              ],
            )),
      viewModelBuilder: () => OrderHistoryTabViewModel(customer: customer),
    );
  }
}
