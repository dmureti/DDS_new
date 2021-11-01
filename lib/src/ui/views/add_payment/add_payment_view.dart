import 'package:distributor/core/helper.dart';
import 'package:distributor/ui/shared/ui_helpers.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/ui/widgets/dumb_widgets/button_submit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import './add_payment_view_model.dart';
import 'package:distributor/core/enums.dart';

class AddPaymentView extends StatelessWidget {
  final Customer customer;

  const AddPaymentView({Key key, this.customer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPaymentViewModel>.reactive(
      viewModelBuilder: () => AddPaymentViewModel(customer),
      builder: (
        BuildContext context,
        AddPaymentViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: AppBarColumnTitle(
              mainTitle: 'Add Payment',
              subTitle: customer.name,
            ),
          ),
          // resizeToAvoidBottomPadding: true,
          resizeToAvoidBottomInset: true,
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView(
              children: [
                DropdownButton(
                  iconEnabledColor: Colors.pink,
                  dropdownColor: Colors.white,
                  value: model.paymentMode,
                  hint: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Select Payment mode'),
                  ),
                  items: model.paymentModes
                      .map(
                        (e) => DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.toString().split(".").last),
                          ),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    model.setPaymentMode(val);
                  },
                  isExpanded: true,
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () async {
                    var result = await showDatePicker(
                        lastDate: model.lastDate,
                        firstDate: model.firstDate,
                        initialDate: model.initialDate,
                        context: (context));
                    if (result is DateTime) {
                      model.updateTransactionDate(result);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(model.transactionDate == null
                                ? 'Transaction date'
                                : Helper.formatDate(model.transactionDate)),
                            Icon(Icons.arrow_drop_down),
                          ],
                        )),
                  ),
                ),
                kSmallVerticalSizedBox,
                _Amount(),
                model.paymentMode == null
                    ? Container()
                    : model.paymentMode == PaymentModes.Cash
                        ? Column(
                            children: [
                              _Remarks(),
                              kMediumVerticalSizedBox,
                              model.isBusy
                                  ? BusyWidget()
                                  : ButtonSubmit(
                                      label: 'SUBMIT',
                                      onPressed: model.submit,
                                    )
                            ],
                          )
                        : Column(
                            children: [
                              kSmallVerticalSizedBox,
                              Row(
                                children: [
                                  Expanded(child: _ExternalAccountId()),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(child: _ExternalReference())
                                ],
                              ),
                              kSmallVerticalSizedBox,
                              _TelephoneNumber(),
                              kSmallVerticalSizedBox,
                              _PayerName(),
                              kSmallVerticalSizedBox,
                              _Remarks(),
                              kMediumVerticalSizedBox,
                              model.isBusy
                                  ? BusyWidget()
                                  : ButtonSubmit(
                                      label: 'SUBMIT',
                                      onPressed: model.submit,
                                    )
                            ],
                          ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ExternalAccountId extends HookViewModelWidget<AddPaymentViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, AddPaymentViewModel model) {
    var refCont = useTextEditingController();
    return TextField(
      onChanged: (val) {
        model.updateExternalAccountId(refCont.text);
      },
      controller: refCont,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Till Number'),
    );
  }
}

class _ExternalReference extends HookViewModelWidget<AddPaymentViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, AddPaymentViewModel model) {
    var refCont = useTextEditingController();
    return TextField(
      onChanged: (val) {
        model.updateExternalTxnID(refCont.text);
      },
      controller: refCont,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'External Reference'),
    );
  }
}

class _TelephoneNumber extends HookViewModelWidget<AddPaymentViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, AddPaymentViewModel model) {
    var refTel = useTextEditingController(text: model.customer.telephone ?? "");
    return TextField(
      controller: refTel,
      keyboardType: TextInputType.phone,
      onChanged: (val) {
        model.updatePayerAccount(val);
      },
      decoration: InputDecoration(
        labelText: 'Payer Telephone',
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: refTel.clear,
        ),
      ),
    );
  }
}

class _PayerName extends HookViewModelWidget<AddPaymentViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, AddPaymentViewModel model) {
    var payerNameCont =
        useTextEditingController(text: model.customer.name ?? "");
    return TextField(
      controller: payerNameCont,
      keyboardType: TextInputType.name,
      onChanged: (val) {
        model.updatePayerName(val);
      },
      decoration: InputDecoration(
        labelText: 'Payer Name',
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: payerNameCont.clear,
        ),
      ),
    );
  }
}

class _Amount extends HookViewModelWidget<AddPaymentViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, AddPaymentViewModel model) {
    var amountCont = useTextEditingController();
    return TextField(
      onChanged: (val) {
        model.updateAmount(val);
      },
      controller: amountCont,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Amount',
      ),
    );
  }
}

class _Remarks extends HookViewModelWidget<AddPaymentViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, AddPaymentViewModel model) {
    var remarksCont = useTextEditingController();
    return TextField(
      controller: remarksCont,
      onChanged: (val) {
        model.updateUserTrxNarrative(remarksCont.text);
      },
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Remarks',
      ),
    );
  }
}
