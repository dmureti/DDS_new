import 'package:distributor/src/strings.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:distributor/ui/widgets/dumb_widgets/product_quantity_tile.dart';
import 'package:distributor/ui/widgets/smart_widgets/stock_list_widget/stock_list_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StockListWidget extends StatelessWidget {
  final bool rebuild;

  const StockListWidget({Key key, this.rebuild = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StockListWidgetViewModel>.reactive(
        fireOnModelReadyOnce: false,
        disposeViewModel: true,
        onModelReady: (model) => model.init(),
        createNewModelOnInsert: true,
        builder: (context, model, child) =>
            model.productList == null || model.isBusy
                ? Center(child: BusyWidget())
                : model.productList.isEmpty
                    ? Center(
                        child: EmptyContentContainer(
                            label: model.isMiniShop
                                ? kStringShopNoStock
                                : kStringNoStock))
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          Product product = model.productList[index];
                          return ProductQuantityTile(product: product);
                        },
                        itemCount: model.productList.length,
                      ),
        viewModelBuilder: () => StockListWidgetViewModel(rebuild));
  }
}
