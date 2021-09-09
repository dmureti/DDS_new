import 'package:distributor/src/ui/views/stock_transaction/stock_transaction_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
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
                        return ListTile(
                          title: Row(
                            children: [
                              Text(transaction.stockTransactionId),
                              Text(transaction.voucherType),
                              Text(transaction.transactionStatus),
                            ],
                          ),
                          subtitle: Text(transaction.entryDate),
                          onTap: model.navigateToVoucherDetailView(
                              transaction.stockTransactionId),
                          trailing: IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: null,
                          ),
                        );
                      },
                    ),
            ),
          );
        },
        viewModelBuilder: () => StockTransactionViewmodel());
  }
}
