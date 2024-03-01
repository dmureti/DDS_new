import 'package:distributor/src/ui/views/quotation_view/quotation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ConfirmQuotationViewModel extends StatelessWidget {
  const ConfirmQuotationViewModel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuotationViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold();
      },
      viewModelBuilder: () => QuotationViewModel(),
    );
  }
}
