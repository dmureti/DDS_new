import 'package:distributor/src/ui/views/stock_transaction/stock_transaction_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:distributor/ui/widgets/dumb_widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StockTransactionListView extends StatelessWidget {
  const StockTransactionListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StockTransactionViewmodel>.reactive(
        onModelReady: (model) => model.getStockTransactions(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Pending Transactions'),
            ),
            body: Container(
              child: model.stockTransactionList == null
                  ? BusyWidget()
                  : ListView.builder(
                      itemCount: model.stockTransactionList.length,
                      itemBuilder: (context, index) {
                        var transaction = model.stockTransactionList[index];
                        return TransactionTile(
                          transaction,
                          onTap: () async {
                            await model.navigateToVoucherDetail(transaction);
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
