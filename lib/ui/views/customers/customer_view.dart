import 'package:distributor/core/models/customer_search_delegate.dart';
import 'package:distributor/ui/views/customers/customer_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_search.dart';
import 'package:distributor/ui/widgets/dumb_widgets/customer_list_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CustomerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              color: Colors.indigo,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppBarSearch(
                    delegate: CustomerSearchDelegate(
                        customerList: model.customerList,
                        onTap: model.navigateToCustomer),
                  ),
                  IconButton(
                    icon: Icon(Icons.sort_by_alpha,
                        color:
                            model.isAsc == true ? Colors.white : Colors.pink),
                    onPressed: () {
                      model.updateIsAsc();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: model.isBusy ? BusyWidget() : CustomerListWidget(),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => CustomerViewModel(),
    );
  }
}
