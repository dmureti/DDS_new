import 'package:distributor/src/ui/views/adhoc_payment/adhoc_payment_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AdhocPaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdhocPaymentViewmodel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(''),
            ),
            body: Container(),
          );
        },
        viewModelBuilder: () => AdhocPaymentViewmodel());
  }
}
