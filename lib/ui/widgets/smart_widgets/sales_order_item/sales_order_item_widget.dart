import 'package:distributor/core/helper.dart';
import 'package:distributor/ui/views/orders/create_order/sales_order_view_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:stacked_services/stacked_services.dart';
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
                    var input = await showQuantityDialog(
                        quantity: model.quantity, model: model);
                    //Check the difference
                    int difference = input - model.quantity;
                    if (difference < 0) {
                      salesOrderViewModel.decreaseSalesOrderItems(
                          model.product, input);
                      if (model.total >= 0 && model.quantity > 0) {
                        salesOrderViewModel
                            .addToTotal(model.product.itemPrice * difference);
                      }
                      model.removeItemQuantity(val: input);
                    } else if (difference > 0) {
                      salesOrderViewModel.increaseSalesOrderItems(
                          model.product, 1);
                      salesOrderViewModel
                          .addToTotal(model.product.itemPrice * difference);
                      model.addItemQuantity(val: input);
                    } else {
                      print('equal');
                    }
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

showQuantityDialog(
    {@required int quantity, @required SalesOrderItemModel model}) async {
  TextEditingController _textEditingController =
      TextEditingController(text: model.quantity.toString());
  return await showDialog(
      context: StackedService.navigatorKey.currentContext,
      builder: (context) {
        return Center(
          child: Material(
            elevation: 3,
            type: MaterialType.card,
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit Quantity'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.pink,
                              fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
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
                      keyboardType: TextInputType.number,
                      controller: _textEditingController,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                        onPressed: () {
                          model.setQuantity(_textEditingController.text);
                        },
                        icon: Icon(Icons.send),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

// TextFormField(
// autofocus: true,
// inputFormatters: [
// WhitelistingTextInputFormatter
//     .digitsOnly
// ],
// keyboardType: TextInputType.number,
// onChanged: (value) {
// newQuantity = int.parse(value);
// },
// initialValue: model.quantity.toString(),
// decoration: InputDecoration(
// suffixIcon: IconButton(
// icon: Icon(FontAwesomeIcons.save),
// onPressed: () {
// //Make sure that the total is not zero
// salesOrderViewModel
//     .editQuantityManually(
// model.product, newQuantity);
// if (model.total >= 0) {
// // Check if new quantity is less than the initial
// if (initialQuantity < newQuantity) {
// model.updateQuantity(
// newQuantity.toString(),
// model.product);
// num difference =
// newQuantity - initialQuantity;
// salesOrderViewModel.addToTotal(
// difference *
// model.product.itemPrice);
// salesOrderViewModel
//     .increaseSalesOrderItems(
// model.product,
// difference);
// }
// if (initialQuantity > newQuantity) {
// // Less products
// num difference =
// initialQuantity - newQuantity;
// model.updateQuantity(
// newQuantity.toString(),
// model.product);
// salesOrderViewModel
//     .removeFromTotal(difference *
// model.product.itemPrice);
// salesOrderViewModel
//     .decreaseSalesOrderItems(
// model.product,
// difference);
// }
// }
// Navigator.pop(context);
// //
// },
// )),
// )
