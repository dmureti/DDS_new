import 'package:distributor/conf/dds_brand_guide.dart';
import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/ui/views/confirm_stock_transfer/confirm_stock_transfer_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ConfirmStockTransferView extends StatelessWidget {
  final List<Product> stockTransferItems;
  const ConfirmStockTransferView({Key key, this.stockTransferItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConfirmStockTransferViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Confirm Stock Transfer Items'),
            ),
            body: stockTransferItems.isEmpty
                ? Center(
                    child: EmptyContentContainer(
                        label: 'You have not selected any items.'),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            var stockTransferItem =
                                model.stockTransferItems[index];
                            return ListTile(
                              trailing:
                                  Text(stockTransferItem.quantity.toString()),
                              title: Text(
                                stockTransferItem.itemName,
                                style: kTileLeadingTextStyle,
                              ),
                              subtitle: Text(
                                '${stockTransferItem.itemCode}',
                                style: kTileSubtitleTextStyle,
                              ),
                            );
                          },
                          itemCount: model.stockTransferItems.length,
                        ),
                      ),
                      model.isBusy
                          ? BusyWidget()
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: model.commit,
                                child: Text('SUBMIT'.toUpperCase()),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        kColDDSPrimaryDark)),
                              ),
                            )
                    ],
                  ),
          );
        },
        viewModelBuilder: () =>
            ConfirmStockTransferViewModel(stockTransferItems));
  }
}
