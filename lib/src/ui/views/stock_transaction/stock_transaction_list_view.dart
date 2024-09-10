import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/src/ui/views/stock_transaction/stock_transaction_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:distributor/ui/widgets/dumb_widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StockTransactionListView extends StatelessWidget {
  const StockTransactionListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StockTransactionViewmodel>.reactive(
        onModelReady: (model) => model.getStockTransactions(),
        fireOnModelReadyOnce: false,
        disposeViewModel: true,
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Pending Transactions',
                style: kAppBarTextStyle,
              ),
            ),
            body: Container(
              child: model.stockTransactionList == null
                  ? Center(child: BusyWidget())
                  : model.stockTransactionList.isEmpty
                      ? Center(
                          child: EmptyContentContainer(
                              label:
                                  'There are no pending transactions at the moment.'),
                        )
                      : ListView.builder(
                          itemCount: model.stockTransactionList.length,
                          itemBuilder: (context, index) {
                            var transaction = model.stockTransactionList[index];
                            return TransactionTile(
                              transaction,
                              onTap: () async {
                                await model
                                    .navigateToVoucherDetail(transaction);
                                model.getStockTransactions();
                              },
                            );
                          },
                        ),
            ),
          );
        },
        viewModelBuilder: () => StockTransactionViewmodel());
  }
}
