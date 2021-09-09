import 'package:distributor/src/ui/views/stock_transfer/stock_transfer_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StockTransferView extends StatelessWidget {
  const StockTransferView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StockTransferViewmodel>.reactive(
        onModelReady: (model) => model.fetchStockBalance(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Return Stock'),
            ),
            body: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model.salesChannel),
                      Text('Main Warehouse')
                    ],
                  ),
                  model.productList == null
                      ? BusyWidget()
                      : Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Container();
                            },
                            itemCount: model.productList.length,
                          ),
                        ),
                  Container(
                    height: 50,
                    child: model.isBusy
                        ? BusyWidget()
                        : ElevatedButton(
                            child: Text('Return to Branch'),
                            onPressed: model.enableReturnToBranch
                                ? () => model.transferStock()
                                : null,
                          ),
                  )
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => StockTransferViewmodel());
  }
}
