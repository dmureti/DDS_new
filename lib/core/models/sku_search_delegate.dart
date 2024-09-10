import 'package:distributor/ui/views/orders/create_order/sales_order_view_model.dart';
import 'package:distributor/ui/widgets/smart_widgets/sales_order_item/sales_order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

class SKUSearchDelegate extends SearchDelegate {
  final SalesOrderViewModel model;
  final onTap;

  SKUSearchDelegate({this.onTap, @required this.model});

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
    //Get the details of this item from the model
    var product = selectedSku;
    return Container(
      height: 100,
      child: SalesOrderItemWidget(
        item: product,
        salesOrderViewModel: model,
      ),
    );
  }

  Product selectedSku;

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Product> result = query.isEmpty || query.length == 0
        ? model.productList
        : model.productList
            .where((sku) =>
                sku.itemName.toLowerCase().contains(query.toLowerCase().trim()))
            .toList();
    return result.isEmpty
        ? Container(
            child: Center(
              child: Text('No results found'),
            ),
          )
        : ListView.separated(
            physics: ClampingScrollPhysics(),
            separatorBuilder: (context, index) {
              return Divider(
                height: 0.1,
              );
            },
            shrinkWrap: true,
            itemCount: result.length,
            itemBuilder: (context, index) {
              var product = result[index];
              selectedSku = model.salesOrderItems
                  .firstWhere(
                      (element) => element.item.itemCode == product.itemCode,
                      orElse: () => SalesOrderItem(item: product, quantity: 4))
                  .item;
              return ListTile(
                title: Text(product.itemName),
                onTap: () {
                  print(selectedSku.quantity);
                  showResults(context);
                },
              );
            });
  }
}
