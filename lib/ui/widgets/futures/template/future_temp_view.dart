import 'package:distributor/ui/widgets/futures/template/future_temp_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FutureTempView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FutureTempViewModel>.reactive(
        builder: (context, model, child) => Scaffold(),
        viewModelBuilder: () => FutureTempViewModel());
  }
}
