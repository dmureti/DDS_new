import 'package:distributor/ui/widgets/smart_widgets/stock_list_widget/stock_list_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StockListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StockListWidgetViewModel>.reactive(
        builder: (context, model, child) => model.isBusy
            ? CircularProgressIndicator()
            : Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    Product product = model.data[index];
                    return ListTile(
                      title: Text(product.itemName),
                      subtitle: Text(product.itemCode),
                      trailing: Text(product.quantity.toStringAsFixed(0)),
                    );
                  },
                  itemCount: model.data.length,
                ),
              ),
        viewModelBuilder: () => StockListWidgetViewModel());
  }
}
