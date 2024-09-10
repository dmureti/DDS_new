import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:distributor/ui/widgets/smart_widgets/crew_order_history/crew_history_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CrewHistoryView extends StatelessWidget {
  const CrewHistoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CrewHistoryViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(),
                model.isBusy
                    ? Center(child: BusyWidget())
                    : model.orders.isEmpty
                        ? EmptyContentContainer(
                            label: 'You have not placed any orders.')
                        : Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                var salesOrder = model.orders[index];
                                return ListTile(
                                  onTap: () {
                                    model.navigateToSalesOrder(salesOrder);
                                  },
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        salesOrder.customerName ?? "",
                                        style: kTileLeadingTextStyle,
                                      ),
                                      Text(salesOrder.orderStatus)
                                    ],
                                  ),
                                  subtitle: Text(
                                    salesOrder.orderNo.toUpperCase(),
                                    style: kTileSubtitleTextStyle,
                                  ),
                                );
                              },
                              itemCount: model.orders.length,
                            ),
                          )
              ],
            ),
        viewModelBuilder: () => CrewHistoryViewModel());
  }
}
