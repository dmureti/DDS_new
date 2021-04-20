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
      onModelReady: (model) => model.fetchCustomerOrders(),
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
                            salesOrderList: model.data,
                            deliveryJourney: null,
                            onTap: model.navigateToOrder),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                model.hasError
                    ? Center(child: Text('An error occurred'))
                    : model.data.length == 0
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
                              itemCount: model.data.length,
                              itemBuilder: (context, int index) {
                                List<SalesOrder> _customerOrdersList =
                                    model.data;
                                SalesOrder salesOrder =
                                    _customerOrdersList[index];
                                DeliveryJourney deliveryJourney = null;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: OrderHistoryTile(model.navigateToOrder,
                                      salesOrder, deliveryJourney),
                                  // child: OrderListTile(
                                  //   orderType: OrderType.salesOrder,
                                  //   onTap: () => model.navigateToOrder(
                                  //       salesOrder, deliveryJourney, null),
                                  //   orderStatus: salesOrder.orderStatus,
                                  //   orderNo: salesOrder.orderNo,
                                  //   items: salesOrder.orderItems,
                                  // ),
                                );
                              },
                            ),
                          ),
              ],
            )),
      viewModelBuilder: () => OrderHistoryTabViewModel(customer: customer),
    );
  }
}
