import 'package:distributor/ui/config/brand.dart';
import 'package:distributor/ui/views/customers/customer_detail/customer_detail_view.dart';
import 'package:distributor/ui/views/customers/customer_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/customer_list_widget.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CustomerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerViewModel>.reactive(
      builder: (context, model, child) => OrientationBuilder(
        builder: (context, orientation) {
          if (MediaQuery.of(context).size.width > 600) {
            model.isLargeScreen = true;
          } else {
            model.isLargeScreen = false;
          }
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: model.isBusy
                    ? Center(child: BusyWidget())
                    : CustomerListWidget(),
              ),
              model.isLargeScreen
                  ? Expanded(
                      flex: 5,
                      child: model.customer == null
                          ? Container(
                              decoration: BoxDecoration(color: kDarkNeutral),
                            )
                          : CustomerDetailView(customer: model.customer))
                  : Container(),
            ],
          );
        },
      ),
      viewModelBuilder: () => CustomerViewModel(),
    );
  }
}
