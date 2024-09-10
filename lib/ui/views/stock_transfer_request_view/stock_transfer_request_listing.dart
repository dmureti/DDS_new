import 'package:distributor/ui/views/stock_transfer_request_view/stock_transfer_request_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:distributor/ui/widgets/dumb_widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StockTransferRequestListing extends StatelessWidget {
  const StockTransferRequestListing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StockTransferRequestListingViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('View Stock Transfer Requests'),
          ),
          body: Container(
            child: model.isBusy
                ? Center(child: BusyWidget())
                : model.stockTransferRequests.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                        itemBuilder: (context, index) {
                          var transaction = model.stockTransferRequests[index];
                          return TransactionTile(
                            transaction,
                            onTap: () async {
                              await model.navigateToVoucherDetail(transaction);
                            },
                          );
                        },
                        itemCount: model.stockTransferRequests.length,
                      ))
                    : Center(
                        child: EmptyContentContainer(
                            label:
                                'You have not made any stock transfer requests'),
                      ),
          ),
        );
      },
      viewModelBuilder: () {
        return StockTransferRequestListingViewModel();
      },
    );
  }
}
