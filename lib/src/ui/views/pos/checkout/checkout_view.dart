import 'package:distributor/src/ui/views/pos/checkout/checkout_viewmodel.dart';
import 'package:distributor/src/ui/views/pos/shared/custom_extended_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckOutViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Checkout'),
            ),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          'Cart Total',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Kshs ${model.total.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: ListView(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Customer Information'.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile(
                                        title: Text('Walk In'),
                                        value: 'walkin',
                                        onChanged: model.setCustomerType,
                                        groupValue: model.customerType,
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                        title: Text('Contract'),
                                        value: 'contract',
                                        onChanged: model.setCustomerType,
                                        groupValue: model.customerType,
                                      ),
                                    )
                                  ],
                                ),
                                _buildCustomerDisplay(
                                    model.customerTypesDisplay),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Payment Info'),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile(
                                        dense: true,
                                        title: Text('Cash'),
                                        value: 'cash',
                                        onChanged: model.setPaymentMode,
                                        groupValue: model.paymentMode,
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                        dense: true,
                                        title: Text('MPesa'),
                                        value: 'mobile',
                                        onChanged: model.setPaymentMode,
                                        groupValue: model.paymentMode,
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                        dense: true,
                                        title: Text('Mixed'),
                                        value: 'mixed',
                                        onChanged: model.setPaymentMode,
                                        groupValue: model.paymentMode,
                                      ),
                                    ),
                                  ],
                                ),
                                _buildPaymentDisplay(model.paymentModeDisplay),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomExtendedButton(
                    label: 'Complete',
                    onPressed: model.isValidated ? model.printReceipt : null,
                  ),
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => CheckOutViewModel());
  }

  _buildCustomerDisplay(CustomerTypesDisplay customerTypesDisplay) {
    switch (customerTypesDisplay) {
      case CustomerTypesDisplay.none:
        return Container();
      case CustomerTypesDisplay.walkin:
        return _WalkinWidget();
      case CustomerTypesDisplay.contract:
        return _CustomerWidget();
      default:
        return Container();
    }
  }

  _buildPaymentDisplay(PaymentModeDisplay paymentModeDisplay) {
    switch (paymentModeDisplay) {
      case PaymentModeDisplay.none:
        return Container();
      case PaymentModeDisplay.cash:
        return _CashConfirmationWidget();
      case PaymentModeDisplay.mixed:
        return _MixedPaymentWidget();
      case PaymentModeDisplay.mobile:
        return _MpesaConfirmationWidget();
      default:
        return Container();
    }
  }
}

class _WalkinWidget extends HookViewModelWidget<CheckOutViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, CheckOutViewModel model) {
    var nameController = useTextEditingController();
    var phoneController = useTextEditingController();
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(label: Text('Customer Name')),
        ),
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(label: Text('Phone Number')),
        ),
      ],
    );
  }
}

class _CustomerWidget extends HookViewModelWidget<CheckOutViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, CheckOutViewModel model) {
    return TextFormField();
  }
}

class _MpesaConfirmationWidget extends HookViewModelWidget<CheckOutViewModel> {
  @override
  Widget buildViewModelWidget(
      BuildContext context, CheckOutViewModel viewModel) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              label: Text(
                'Enter confirmation message',
              ),
              suffixIcon: Icon(Icons.arrow_right_alt_sharp)),
        ),
      ],
    );
  }
}

class _CashConfirmationWidget extends HookViewModelWidget<CheckOutViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, CheckOutViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Receive Ksh ${model.total.toStringAsFixed(2)} cash from customer.'),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              label: Text(
                'Enter amount received',
              ),
              suffixIcon: Icon(Icons.arrow_right_alt_sharp)),
        ),
      ],
    );
  }
}

class _MixedPaymentWidget extends HookViewModelWidget<CheckOutViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, CheckOutViewModel model) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            label: Text(
              'Enter Cash Amount',
            ),
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              label: Text(
                'Enter confirmation message',
              ),
              suffixIcon: TextButton.icon(
                  onPressed: model.validateTransaction,
                  icon: Icon(Icons.arrow_right_alt_sharp),
                  label: Text('Validate'))),
        ),
      ],
    );
  }
}
