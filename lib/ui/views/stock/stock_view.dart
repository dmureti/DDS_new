import 'package:distributor/ui/views/stock/stock_viewmodel.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar_controller/info_bar_controller_view.dart';
import 'package:distributor/ui/widgets/smart_widgets/stock_controller/stock_controller_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:tripletriocore/tripletriocore.dart';

class StockView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StockViewModel>.reactive(
        builder: (context, model, child) => Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  InfoBarController(),
                  model.user.hasSalesChannel
                      ? Container(
                          height: 50,
                          child: ButtonBar(
                            children: [
                              model.renderPendingStockTransactionsButton
                                  ? IconButton(
                                      onPressed: () => model
                                          .navigateToPendingTransactionsView(),
                                      icon: Icon(Icons.update))
                                  : Container(),
                              IconButton(
                                  onPressed: () =>
                                      model.navigateToReturnStockView(),
                                  icon: Icon(Icons.read_more_outlined))
                            ],
                          ),
                        )
                      : Container(),
                  StockControllerWidget()
                ],
              ),
            ),
        viewModelBuilder: () => StockViewModel());
  }

  Widget buildProductList(List<Product> productList) {
    return Expanded(
      child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () {},
                splashColor: Colors.pink.withOpacity(0.5),
                child: ListTile(
                  subtitle: Text('${productList[index].itemCode}'),
                  title: Text('${productList[index].itemName}'),
                  trailing:
                      Text('${productList[index].quantity.toStringAsFixed(0)}'),
                ),
              ),
            );
          }),
    );
  }
}
