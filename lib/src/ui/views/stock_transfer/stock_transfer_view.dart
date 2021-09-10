import 'package:distributor/src/ui/views/stock_transfer/stock_transfer_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:distributor/ui/widgets/smart_widgets/return_stock_tile/return_stock_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StockTransferView extends StatelessWidget {
  const StockTransferView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StockTransferViewmodel>.reactive(
        onModelReady: (model) => model.init(),
        disposeViewModel: true,
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Return Stock To Branch'),
              actions: [
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: model.enableReturnToBranch ? model.reset : null,
                )
              ],
            ),
            body: Container(
              child: model.productList == null
                  ? BusyWidget()
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              Product product = model.productList[index];
                              return ReturnStockTileWidget(
                                product: product,
                                onChange: model.onChange,
                              );
                            },
                            itemCount: model.productList.length,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: model.isBusy
                              ? BusyWidget()
                              : RaisedButton(
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
