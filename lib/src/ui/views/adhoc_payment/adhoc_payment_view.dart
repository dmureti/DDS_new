import 'package:distributor/src/ui/views/adhoc_payment/adhoc_payment_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class AdhocPaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdhocPaymentViewmodel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Adhoc Sales : Payment'),
            ),
            body: Container(
              margin: EdgeInsets.only(
                  left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Amount Due : Kshs ${model.total.toStringAsFixed(2)}'),
                  DropdownButton(
                      key: Key('paymentmodes'),
                      items: model.paymentModes
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      value: model.paymentMode,
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      hint: Text('Select payment mode'),
                      onChanged: (val) {
                        model.setPaymentType(val);
                      }),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  _RemarksTextField(),
                  SizedBox(
                    width: 24,
                  ),
                  model.isBusy
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            onPressed: () {
                              model.completeAdhoc();
                            },
                            child: Text('COMPLETE'),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => AdhocPaymentViewmodel());
  }
}

class _RemarksTextField extends HookViewModelWidget<AdhocPaymentViewmodel> {
  @override
  Widget buildViewModelWidget(
      BuildContext context, AdhocPaymentViewmodel model) {
    var remarksController = useTextEditingController();
    return TextFormField(
      controller: remarksController,
      minLines: 1,
      maxLines: 3,
      onChanged: model.updateRemarks,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'Remarks',
      ),
    );
  }
}
