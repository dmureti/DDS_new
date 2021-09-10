import 'package:distributor/ui/widgets/dumb_widgets/product_quantity_tile.dart';
import 'package:distributor/ui/widgets/smart_widgets/stock_list_widget/stock_list_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StockListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StockListWidgetViewModel>.reactive(
        onModelReady: (model) => model.fetchStockBalance(),
        builder: (context, model, child) => model.productList == null
            ? CircularProgressIndicator()
            : Expanded(
                child: model.productList.isEmpty
                    ? Container(
                        child: Center(
                          child: Text('The vehicle has no stock.'),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          Product product = model.productList[index];
                          return ProductQuantityTile(product: product);
                        },
                        itemCount: model.productList.length,
                      ),
              ),
        viewModelBuilder: () => StockListWidgetViewModel());
  }
}
