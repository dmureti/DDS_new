import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/src/ui/views/pos/sales_returns/sales_returns_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SalesReturnsView extends StatelessWidget {
  const SalesReturnsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesReturnsViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Sales Returns'),
            ),
            body: model.isBusy
                ? Center(child: BusyWidget())
                : model.salesReturns.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(itemBuilder: (context, index) {
                        var salesReturn = model.salesReturns[index];
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                salesReturn['customerName'] ?? "",
                                style: kTileLeadingTextStyle,
                              ),
                              Text(
                                salesReturn['status'] ?? "",
                              ),
                            ],
                          ),
                          subtitle: Text(
                            salesReturn['returnId'] ?? "",
                            style: kTileSubtitleTextStyle,
                          ),
                        );
                      }))
                    : Center(child: Text('No Sales Returns found')),
          );
        },
        viewModelBuilder: () => SalesReturnsViewModel());
  }
}
