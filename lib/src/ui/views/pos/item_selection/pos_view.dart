import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/src/ui/views/pos/item_selection/pos_viewmodel.dart';
import 'package:distributor/src/ui/views/pos/pos_card_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import '../../../../../ui/widgets/quantity_input/quantity_input_view.dart';

class POSView extends StatelessWidget {
  const POSView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<POSViewmodel>.reactive(
      viewModelBuilder: () => POSViewmodel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Make New Sale'),
            actions: [
              IconButton(
                  onPressed: () => model.navigateToCart(model.itemsInCart),
                  icon: Icon(Icons.shopping_cart))
            ],
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: model.search, icon: Icon(Icons.search)),
                  IconButton(onPressed: model.sort, icon: Icon(Icons.sort)),
                  IconButton(
                      onPressed: model.vert, icon: Icon(Icons.more_vert)),
                  IconButton(
                    onPressed: model.toggleView,
                    icon: Icon(
                      Icons.list,
                      color: model.isToggled ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
              model.isBusy
                  ? BusyWidget()
                  : Expanded(
                      child: model.isToggled
                          ? ListView.builder(
                              itemCount: model.items.length,
                              itemBuilder: (context, index) {
                                var item = model.items[index];
                                return GestureDetector(
                                  onPanUpdate: (details) {},
                                  key: key,
                                  child: ListTile(
                                    onLongPress: () =>
                                        model.navigateToItem(item),
                                    onTap: () async {
                                      var result = await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return QuantityInput(
                                            title: 'Enter Quantity',
                                            minQuantity: 0,
                                            maxQuantity: 200000,
                                            description:
                                                'How many pcs for ${item.itemName} would you like to order ?',
                                            initialQuantity:
                                                model.getQuantity(item),
                                          );
                                        },
                                      );
                                      print(result);
                                      if (result != null) {
                                        model.updateQuantity(
                                            product: item, newVal: result);
                                      }
                                    },
                                    leading: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.2)),
                                    ),
                                    title: Text(
                                      item.itemName,
                                      style: kTileLeadingTextStyle,
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${item.itemPrice.toStringAsFixed(2)}'),
                                        Text(model
                                            .getTotal(item)
                                            .toStringAsFixed(2))
                                      ],
                                    ),
                                    trailing: Text(
                                        model.getQuantity(item).toString()),
                                  ),
                                );
                              },
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 150,
                                        crossAxisSpacing: 10,
                                        mainAxisExtent: 200),
                                itemBuilder: (context, index) {
                                  var item = model.items[index];
                                  return POSCardWidget(
                                    item: item,
                                  );
                                },
                                itemCount: model.items.length,
                                scrollDirection: Axis.vertical,
                              ),
                            ),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDetails(BuildContext context, var item) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text(
              item.name,
              style: context.textTheme.titleSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(item.itemCode,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
