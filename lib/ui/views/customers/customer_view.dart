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
                  !model.isBusy
                      ? IconButton(
                          icon: Icon(Icons.filter_list),
                          onPressed: () async {
                            return await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (BuildContext ctx) {
                                  return StatefulBuilder(
                                    builder: (ctx, state) {
                                      return SafeArea(
                                        child: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 50,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        'Filter',
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      IconButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        icon: Icon(Icons.close),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemBuilder:
                                                        (context, index) {
                                                      String branch =
                                                          model.branches[index];
                                                      return CheckboxListTile(
                                                        value:
                                                            model.route[branch],
                                                        onChanged: (value) {
                                                          model.updateFilters(
                                                              value, branch);
                                                        },
                                                        title: Text(branch),
                                                      );
                                                    },
                                                    itemCount:
                                                        model.branches.length,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      );
                                    },
                                  );
                                });
                          },
                        )
                      : Container()
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
