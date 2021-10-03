import 'package:distributor/core/helper.dart';
import 'package:distributor/src/ui/text_styles.dart';
import 'package:distributor/ui/widgets/dumb_widgets/product_quantity_container.dart';
import 'package:distributor/ui/widgets/smart_widgets/manual_input_widget/manual_input_widget.dart';
import 'package:stacked/stacked.dart';
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
        margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 4.0, top: 4.0),
        child: Material(
          type: MaterialType.card,
          elevation: model.isEnabled ? 1.0 : 0.0,
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
                        fontWeight: FontWeight.w600),
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
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(model.isEnabled
                      ? 'Kshs ${Helper.formatCurrency(model.total)}'
                      : 'NA'),
                  Spacer(),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.black12, width: 2),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: model.isEnabled
                                  ? model.quantity == 0
                                      ? null
                                      : () {
                                          salesOrderViewModel
                                              .decreaseSalesOrderItems(
                                                  model.product, 1);
                                          if (model.total >= 0 &&
                                              model.quantity > 0) {
                                            salesOrderViewModel.removeFromTotal(
                                                model.product.itemPrice);
                                          }
                                          model.removeItemQuantity();
//                    print(salesOrderViewModel.total.toStringAsFixed(2));
                                        }
                                  : null,
                              icon: Icon(Icons.remove_circle),
                              visualDensity: VisualDensity.compact,
                            ),
                            GestureDetector(
                              onTap: () async {
                                var difference = await showQuantityDialog(
                                    quantity: model.quantity, model: model);
                                if (difference is int) {
                                  num totalDifference =
                                      difference * model.product.itemPrice;
                                  //update the salesOrderViewmodel
                                  salesOrderViewModel
                                      .addToTotal(totalDifference);
                                  // Get the difference in terms of quantity
                                  num differenceInQuantity =
                                      totalDifference / model.product.itemPrice;
                                  if (differenceInQuantity != 0) {
                                    /// Check if there was an overall reduction in cart items
                                    /// If the difference is less than zero
                                    /// The number of cart items shall reduce
                                    if (differenceInQuantity < 0) {
                                      salesOrderViewModel
                                          .decreaseSalesOrderItems(
                                              model.product,
                                              (-(differenceInQuantity))
                                                  .toInt());
                                    } else {
                                      salesOrderViewModel
                                          .increaseSalesOrderItems(
                                              model.product,
                                              differenceInQuantity.toInt());
                                    }
                                  }
                                }
                              },
                              child: ProductQuantityContainer(
                                quantity: model.quantity,
                                style: kCartQuantity,
                                secondaryStyle: kCartSecondaryStyle,
                              ),
                            ),
                            IconButton(
                              onPressed: model.isEnabled
                                  ? model.maxQuantity != null &&
                                          model.quantity < model.maxQuantity
                                      ? () {
                                          salesOrderViewModel
                                              .increaseSalesOrderItems(
                                                  model.product, 1);
                                          salesOrderViewModel.addToTotal(
                                              model.product.itemPrice);
                                          model.addItemQuantity();
//
                                        }
                                      : model.maxQuantity == null
                                          ? () {
                                              salesOrderViewModel
                                                  .increaseSalesOrderItems(
                                                      model.product, 1);
                                              salesOrderViewModel.addToTotal(
                                                  model.product.itemPrice);
                                              model.addItemQuantity();
//
                                            }
                                          : null
                                  : null,
                              icon: Icon(
                                Icons.add_circle,
                              ),
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

showQuantityDialog(
    {@required int quantity, @required SalesOrderItemModel model}) async {
  return await showDialog(
      context: StackedService.navigatorKey.currentContext,
      builder: (context) {
        bool isAdhocSale = model.maxQuantity != null;
        return ManualInputWidget(
          quantity: quantity.toInt(),
          maxQuantity: model.maxQuantity,
          isAdhocSale: isAdhocSale,
          product: model.product,
          onPressed: model.processManualInput,
        );
      });
}
