import 'package:auto_route/auto_route.dart';
import 'package:distributor/src/ui/views/voucher_detail/voucher_detail_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class VoucherDetailView extends StatelessWidget {
  final String transactionId;

  const VoucherDetailView({Key key, @required this.transactionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VoucherDetailViewmodel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Voucher Details'),
            ),
            body: Container(
              child: model.stockTransaction == null
                  ? BusyWidget()
                  : Column(
                      children: [
                        Row(
                          children: [
                            Text(
                                'Entry Date : ${model.stockTransaction.entryDate}'),
                            SwitchListTile(
                              value: model.status,
                              onChanged: model.toggleStatus,
                              title: Text(''),
                            ),
                          ],
                        ),
                        Text('Remarks'),
                        Text('Items'),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            var stockItem = model.stockTransaction.items[index];
                            Item item = Item.fromMap(stockItem);
                            return Row(
                              children: [
                                Text(item.itemCode),
                                Text(item.itemName),
                                Text('stockItem.'),
                              ],
                            );
                          },
                          itemCount: model.stockTransaction.items.length,
                        )
                      ],
                    ),
            ),
          );
        },
        viewModelBuilder: () => VoucherDetailViewmodel(transactionId));
  }
}
