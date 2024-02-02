import 'package:distributor/src/ui/views/pos/confirm_cart/confirm_cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class ConfirmCartView extends StatelessWidget {
  const ConfirmCartView({Key key}) : super(key: key);

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
                Expanded(child: ListView()),
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
