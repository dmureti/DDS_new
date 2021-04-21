import 'package:distributor/core/helper.dart';
import 'package:distributor/ui/views/orders/create_order/sales_order_view_model.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:flutter/material.dart';

import 'sales_order_item_model.dart';

class SalesOrderItemWidget<T> extends StatelessWidget {
  final Product item;
  final salesOrderViewModel;
  final quantity;

  SalesOrderItemWidget(
      {@required this.item, @required this.salesOrderViewModel, this.quantity});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesOrderItemModel>.reactive(
      viewModelBuilder: () =>
          SalesOrderItemModel(product: item, maxQuantity: quantity),
      builder: (context, model, child) => Container(
        margin:
            EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
        child: Material(
          type: MaterialType.card,
          elevation: model.isEnabled ? 3.0 : 0.0,
          child: ListTile(
            title: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${item.itemName}',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        decorationThickness: 1,
                        color: Colors.indigo,
                        fontWeight: FontWeight.w700),
//                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    width: 100,
                    child: Text(
                      model.isEnabled
                          ? 'Kshs ${item.itemPrice.toStringAsFixed(2)}'
                          : '-',
//                    'Kshs ${item.itemPrice}',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            )),
            isThreeLine: true,
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(model.isEnabled
                    ? 'Kshs ${Helper.formatCurrency(model.total)}'
                    : 'NA'),
                Spacer(),
                IconButton(
                  onPressed: model.isEnabled
                      ? () {
                          salesOrderViewModel.decreaseSalesOrderItems(
                              model.product, 1);
                          if (model.total >= 0 && model.quantity > 0) {
                            salesOrderViewModel
                                .removeFromTotal(model.product.itemPrice);
                          }
                          model.removeItemQuantity();
//                    print(salesOrderViewModel.total.toStringAsFixed(2));
                        }
                      : null,
                  icon: Icon(Icons.remove_circle),
                ),
                GestureDetector(
                  onTap: () async {
                    int initialQuantity = model.quantity;
                    int newQuantity = model.quantity;
                    await showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) => Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Edit Quantity'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(model.product.itemName),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      autofocus: true,
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        newQuantity = int.parse(value);
                                      },
                                      initialValue: model.quantity.toString(),
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                        icon: Icon(FontAwesomeIcons.save),
                                        onPressed: () {
                                          //Make sure that the total is not zero
                                          salesOrderViewModel
                                              .editQuantityManually(
                                                  model.product, newQuantity);
                                          if (model.total >= 0) {
                                            // Check if new quantity is less than the initial
                                            if (initialQuantity < newQuantity) {
                                              model.updateQuantity(
                                                  newQuantity.toString(),
                                                  model.product);
                                              num difference =
                                                  newQuantity - initialQuantity;
                                              salesOrderViewModel.addToTotal(
                                                  difference *
                                                      model.product.itemPrice);
                                              salesOrderViewModel
                                                  .increaseSalesOrderItems(
                                                      model.product,
                                                      difference);
                                            }
                                            if (initialQuantity > newQuantity) {
                                              // Less products
                                              num difference =
                                                  initialQuantity - newQuantity;
                                              model.updateQuantity(
                                                  newQuantity.toString(),
                                                  model.product);
                                              salesOrderViewModel
                                                  .removeFromTotal(difference *
                                                      model.product.itemPrice);
                                              salesOrderViewModel
                                                  .decreaseSalesOrderItems(
                                                      model.product,
                                                      difference);
                                            }
                                          }
                                          Navigator.pop(context);
//
                                        },
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  },
                  child: Text(
                    model.quantity.toString(),
                    style: model.quantity == 0
                        ? TextStyle()
                        : TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                ),
                IconButton(
                  onPressed: model.isEnabled
                      ? () {
                          salesOrderViewModel.increaseSalesOrderItems(
                              model.product, 1);
                          salesOrderViewModel
                              .addToTotal(model.product.itemPrice);
                          model.addItemQuantity();
//
                        }
                      : null,
                  icon: Icon(Icons.add_circle),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
