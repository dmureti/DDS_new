import 'package:distributor/ui/views/adhoc_sales/adhoc_sales_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/ui/widgets/dumb_widgets/no_journey_container.dart';

class AdhocSalesView extends StatelessWidget {
  final Customer customer;

  const AdhocSalesView({Key key, this.customer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdhocSalesViewModel>.reactive(
        onModelReady: (model) {
          model.initReactive();
          model.fetchCustomers();
          model.fetchStockBalance();
          model.getUserPOSProfile();
          model.init();
          // model.listWarehouses();
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Adhoc Sales'),
            ),
            body: model.userHasJourneys
                ? Container(
                    child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Stepper(
                              onStepTapped: model.onStepTapped,
                              onStepCancel: model.onStepCancel,
                              currentStep: model.currentIndex,
                              onStepContinue: model.onStepContinue,
                              steps: [
                                Step(
                                  title: Text('Customer Type'),
                                  isActive:
                                      model.currentIndex == 0 ? true : false,
                                  state: model.currentIndex != 0 &&
                                          model.customerType == null
                                      ? StepState.error
                                      : model.currentIndex == 0
                                          ? StepState.editing
                                          : StepState.complete,
                                  content: DropdownButton(
                                    key: Key('selectCustomerTypeKey'),
                                    dropdownColor: Colors.white,
                                    isExpanded: true,
                                    hint: Text('Select a customer type'),
                                    value: model.customerType,
                                    onChanged: model.updateCustomerType,
                                    items: model.customerTypes
                                        .map((e) => DropdownMenuItem(
                                              child: Text(e),
                                              value: e,
                                            ))
                                        .toList(),
                                  ),
                                ),
                                Step(
                                  title: Text('Customer Detail'),
                                  isActive:
                                      model.currentIndex == 1 ? true : false,
                                  state: model.customerType == null
                                      ? StepState.disabled
                                      : model.currentIndex == 1
                                          ? StepState.editing
                                          : StepState.complete,
                                  content: model.customerType != null
                                      ? model.customerType.toLowerCase() ==
                                              'contract'
                                          ? model.customerList == null
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : model.customerList.length > 0
                                                  ? DropdownButton(
                                                      key: Key(
                                                          'selectCustomerKey'),
                                                      dropdownColor:
                                                          Colors.white,
                                                      isExpanded: true,
                                                      hint: Text(
                                                          'Select customer'),
                                                      value: model.customer,
                                                      onChanged:
                                                          model.updateCustomer,
                                                      items: model.customerList
                                                          .map((e) =>
                                                              DropdownMenuItem(
                                                                child: Text(
                                                                    e.name),
                                                                value: e,
                                                              ))
                                                          .toList(),
                                                    )
                                                  : Text('No customers found')
                                          : _CustomerNameTextField()
                                      : Text('Select a customer type'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: model.isCompleted
                                ? () {
                                    model.navigateToCart();
                                  }
                                : null,
                            child: Text('CONTINUE TO CART'),
                          ),
                        ),
                      )
                    ],
                  ))
                : Container(
                    child: Center(
                      child: Text(
                          'You have not been assigned any deliveries today.'),
                    ),
                  ),
          );
        },
        viewModelBuilder: () => AdhocSalesViewModel(customer));
  }
}

class _CustomerNameTextField extends HookViewModelWidget<AdhocSalesViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, AdhocSalesViewModel model) {
    var controller = useTextEditingController();
    return TextFormField(
      controller: controller,
      onChanged: model.updateCustomerName,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'Name of customer',
      ),
    );
  }
}
