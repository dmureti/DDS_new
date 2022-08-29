import 'dart:convert';

import 'package:distributor/src/strings.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:distributor/ui/widgets/smart_widgets/crate_transactions/crate_transaction_listing_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CrateTransactionListingView extends StatelessWidget {
  CrateTransactionListingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CrateTransactionListingViewModel>.reactive(
      onModelReady: (model) => model.init(),
      fireOnModelReadyOnce: false,
      disposeViewModel: true,
      builder: (context, model, child) {
        return model.hasSelectedJourney == true
            ? model.isBusy
                ? Center(child: BusyWidget())
                : model.crateTransactionListings.isNotEmpty
                    ? RefreshIndicator(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var crateTxn =
                                model.crateTransactionListings[index];
                            var description =
                                json.decode(crateTxn['description']);
                            return ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    description['customer'] ??
                                        "Unknown Customer",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Expanded(child: Text(crateTxn['itemName'])),
                                  Text(
                                      "Received : ${description['received'] ?? "-"} | Dropped : ${description['dropped'] ?? "-"}"),
                                ],
                              ),
                            );
                          },
                          itemCount: model.crateTransactionListings.length,
                        ),
                        onRefresh: () => model.getCrateTransactions())
                    : Container(
                        child: Center(
                          child: EmptyContentContainer(
                              label: kStringNoCrateTransactions),
                        ),
                      )
            : Container(
                child: Center(
                  child:
                      EmptyContentContainer(label: kStringNoCrateTransactions),
                ),
              );
      },
      viewModelBuilder: () => CrateTransactionListingViewModel(),
    );
  }
}
