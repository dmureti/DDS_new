import 'package:distributor/ui/shared/ui_helpers.dart';
import 'package:distributor/ui/views/payment_reference/payment_reference_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class PaymentReferenceView extends StatelessWidget {
  final Customer customer;

  const PaymentReferenceView({@required this.customer, Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentReferenceViewmodel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarColumnTitle(
                mainTitle: 'Link Payment',
                subTitle: customer.name,
              ),
            ),
            body: Container(
              margin: kContainerEdgeInsets,
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please enter a reference";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    onChanged: (val) {
                      model.setPaymentReference(val);
                    },
                    decoration: InputDecoration(labelText: 'Payment Reference'),
                  ),
                  kMediumVerticalSizedBox,
                  DropdownButton(
                      dropdownColor: Colors.white,
                      hint: Text('Select payment method'),
                      isExpanded: true,
                      value: model.paymentMode,
                      items: model.paymentTypes
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) => model.updatePaymentMode),
                  model.isBusy
                      ? CircularProgressIndicator()
                      : Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              model.retrievePendingPayment();
                            },
                            child: Text('Get Details'),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => PaymentReferenceViewmodel(customer));
  }
}
