import 'package:distributor/core/models/payment_link.dart';
import 'package:distributor/ui/shared/text_styles.dart';
import 'package:distributor/ui/views/link_payment/link_payment_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class LinkPaymentView extends StatelessWidget {
  final Customer customer;
  final PaymentLink paymentLink;

  LinkPaymentView(
      {@required this.customer, @required this.paymentLink, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LinkPaymentViewmodel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarColumnTitle(
                mainTitle: 'Link Payment',
                subTitle: customer.name,
              ),
            ),
            body: Container(
              margin: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
              child: Column(
                children: [
                  Text(
                    'Please answer the questions to validate and link the payment to ${model.customer.name}\'s account.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Stepper(
                      onStepTapped: (value) {
                        model.onStepTapped(value);
                      },
                      currentStep: model.index,
                      onStepCancel: () {
                        model.onStepCancelled();
                      },
                      onStepContinue: () {
                        model.onStepContinue();
                      },
                      steps: buildSteps(model),
                    ),
                  ),
                  Row(
                    children: [
                      model.isBusy
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              style: ButtonStyle(),
                              onPressed: model.isComplete
                                  ? () {
                                      model.linkPayment();
                                    }
                                  : null,
                              child: Text('SUBMIT'),
                            ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => LinkPaymentViewmodel(customer, paymentLink));
  }

  buildSteps(LinkPaymentViewmodel model) {
    return [
      Step(
        isActive: model.index == 0 ? true : false,
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: model.paymentLink.challengePayerAccount
                .map(
                  (e) => RadioListTile(
                    onChanged: (value) {
                      model.updatePayerAccount(value);
                    },
                    title: Text(e),
                    value: e,
                    groupValue: model.payerAccount,
                  ),
                )
                .toList()),
        title: Text(
          'Payer Number',
          style: kStepperTitleTextStyle,
        ),
      ),
      Step(
        isActive: model.index == 1 ? true : false,
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: model.paymentLink.challengePayerName
                .map(
                  (e) => RadioListTile(
                    onChanged: (value) {
                      model.updatePayerName(value);
                    },
                    title: Text(e),
                    value: e,
                    groupValue: model.payerName,
                  ),
                )
                .toList()),
        title: Text(
          'Payer Name',
          style: kStepperTitleTextStyle,
        ),
      ),
      Step(
        isActive: model.index == 2 ? true : false,
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: model.paymentLink.challengeAmount
                .map(
                  (e) => RadioListTile(
                    onChanged: (value) {
                      model.updateAmount(value);
                    },
                    title: Text(e),
                    value: e,
                    groupValue: model.amount,
                  ),
                )
                .toList()),
        title: Text(
          'Amount',
          style: kStepperTitleTextStyle,
        ),
      ),
    ];
  }
}
