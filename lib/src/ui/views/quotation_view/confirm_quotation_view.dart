import 'package:distributor/src/ui/views/quotation_view/quotation_viewmodel.dart';
import 'package:distributor/ui/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ConfirmQuotationView extends StatelessWidget {
  const ConfirmQuotationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuotationViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Confirm Quotation'),
            ),
            body: ActionButton(
              label: 'Generate Quotation',
              onPressed: model.generateQuotation,
            ));
      },
      viewModelBuilder: () => QuotationViewModel(),
    );
  }
}
