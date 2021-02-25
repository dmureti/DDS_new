import 'package:distributor/ui/widgets/dumb_widgets/order_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

class OrderSearchDelegate extends SearchDelegate {
  final List<SalesOrder> _salesOrderList;
  final DeliveryJourney _deliveryJourney;
  final onTap;

  OrderSearchDelegate(
      {List<SalesOrder> salesOrderList,
      DeliveryJourney deliveryJourney,
      this.onTap})
      : _salesOrderList = salesOrderList,
        _deliveryJourney = deliveryJourney;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OrderHistoryTile(onTap, _selectedSalesOrder, _deliveryJourney),
    );
  }

  SalesOrder _selectedSalesOrder;

  @override
  Widget buildSuggestions(BuildContext context) {
    final myList = query.isEmpty || query.length == 0
        ? _salesOrderList
        : _salesOrderList
            .where((salesOrder) =>
                salesOrder.orderNo.toLowerCase().contains(query.toLowerCase()))
            .toList();
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return myList.isEmpty
        ? Container(child: Center(child: Text('No results found')))
        : Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: query.isEmpty
                    ? Text("Showing all sales orders")
                    : Text('${myList.length.toString()} results found.'),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final salesOrder = myList[index];
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          type: MaterialType.card,
                          elevation: 2,
                          child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(salesOrder.orderNo),
                                  Text(salesOrder.orderStatus)
                                ],
                              ),
//                        subtitle: Row(
//                          children: <Widget>[
//                            Text(
//                                'Ordered : ${Helper.getDay(salesOrder.orderDate.toString())}'),
//                            Text(
//                                'Due : ${Helper.getDay(salesOrder.dueDate.toString())}')
//                          ],
//                        ),
                              onTap: () {
                                _selectedSalesOrder = salesOrder;
                                showResults(context);
                              }),
                        ),
                      ),
                    );
                  },
                  itemCount: myList.length,
                ),
              ),
            ],
          );
  }
}
