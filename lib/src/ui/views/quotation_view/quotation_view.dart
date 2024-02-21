import 'package:distributor/src/ui/views/pos/styles/text.dart';
import 'package:distributor/src/ui/views/quotation_view/quotation_viewmodel.dart';
import 'package:distributor/ui/widgets/action_button.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/generic_container.dart';
import 'package:distributor/ui/widgets/quantity_input/quantity_input_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class QuotationView extends StatelessWidget {
  const QuotationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuotationViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Create Quotation'),
          ),
          body: GenericContainer(
            child: model.isBusy
                ? Center(child: BusyWidget())
                : model.items != null && model.items.isNotEmpty
                    ? Column(
                        children: [
                          ListView.builder(
                            itemCount: model.items.length,
                            itemBuilder: (context, index) {
                              var item = model.items[index];
                              return Dismissible(
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    //Add to the quantity
                                    var newVal = item.quantity + 1;
                                    model.updateQuantity(
                                        product: item, newVal: newVal);
                                  }
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    //Reduce the quantity
                                    var newVal = item.quantity - 1;
                                    if (newVal >= 0) {
                                      model.updateQuantity(
                                          product: item, newVal: newVal);
                                    }
                                  }
                                  return false;
                                },
                                key: Key(item.itemCode),
                                child: ListTile(
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
                                    style: productNameTextStyle,
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
                                  trailing:
                                      Text(model.getQuantity(item).toString()),
                                ),
                              );
                            },
                          ),
                          ActionButton(
                            onPressed: model.placeQuotation,
                            label: 'Send Quotation',
                          )
                        ],
                      )
                    : Center(
                        child: Text("There are no items available."),
                      ),
          ),
        );
      },
      viewModelBuilder: () => QuotationViewModel(),
    );
  }
}
