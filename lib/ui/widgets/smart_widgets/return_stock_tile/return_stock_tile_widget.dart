import 'package:distributor/ui/widgets/smart_widgets/return_stock_tile/return_stock_tile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ReturnStockTileWidget extends StatelessWidget {
  final Product product;
  final Function onChange;
  const ReturnStockTileWidget({Key key, this.product, @required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReturnStockTileViewmodel>.reactive(
        builder: (context, model, child) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Container(
                  child: Text(model.getBalance),
                  width: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.itemName),
                    Text(product.itemCode),
                  ],
                ),
                Spacer(),
                Container(
                  width: 120,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: model.canRemove
                            ? () {
                                //Update the product
                                // onChange();
                                model.remove();
                                // onRemove(model.item, val: model.quantity);
                                onChange(model.product);
                              }
                            : null,
                        icon: Icon(Icons.remove_circle_outline),
                      ),
                      Container(
                          width: 20,
                          child: Text(model.quantity.toStringAsFixed(0))),
                      IconButton(
                          onPressed: model.canAdd
                              ? () {
                                  model.add();
                                  // onAdd(model.item, val: model.quantity);
                                  onChange(model.product);
                                }
                              : null,
                          icon: Icon(Icons.add_circle_outline)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        viewModelBuilder: () => ReturnStockTileViewmodel(product, onChange));
  }
}
