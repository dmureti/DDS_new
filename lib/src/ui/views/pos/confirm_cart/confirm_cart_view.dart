import 'package:distributor/src/ui/views/pos/confirm_cart/confirm_cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ConfirmCartView extends StatelessWidget {
  final List orderedItems;
  const ConfirmCartView({Key key, @required this.orderedItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConfirmCartViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Confirm Items'),
            actions: [
              IconButton(
                  onPressed: () => print("delete"), icon: Icon(Icons.clear))
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    var item = orderedItems[index];
                    return ListTile(
                      title: Row(
                        children: [
                          Text(item.quantity.toString()),
                          SizedBox(
                            width: 10,
                          ),
                          Text(item.itemName),
                          Spacer(),
                          Text((item.quantity * item.itemPrice)
                              .toStringAsFixed(2)),
                        ],
                      ),
                    );
                  },
                  itemCount: orderedItems.length,
                )),
                Container(
                  child: ElevatedButton(
                      child: Text('Proceed to Checkout'),
                      onPressed: model.navigateToCheckOut),
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ConfirmCartViewModel(),
    );
  }
}
