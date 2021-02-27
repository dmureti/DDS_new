import 'package:distributor/ui/views/adhoc_sales/adhoc_sales_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AdhocSalesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdhocSalesViewModel>.reactive(
        builder: (context, model, child) {
          return Container();
        },
        viewModelBuilder: () => AdhocSalesViewModel());
  }
}
