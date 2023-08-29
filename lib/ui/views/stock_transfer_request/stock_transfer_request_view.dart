import 'package:distributor/conf/dds_brand_guide.dart';
import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/ui/views/stock_transfer_request/stock_transfer_request_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/dumb_widgets/busy_widget.dart';

class StockTransferRequestView extends StatelessWidget {
  const StockTransferRequestView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StockTransferRequestViewModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => StockTransferRequestViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Stock Transfer Request'),
          ),
          body: model.isBusy
              ? Center(child: BusyWidget())
              : model.productList.isNotEmpty
                  ? Column(
                      children: [
                        //@Todo Transfer Type
                        //@Todo Source branch
                        //@Todo Destination shop
                        //@Todo Items to transfer
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              var product = model.productList[index];
                              return ListTile(
                                visualDensity: VisualDensity.compact,
                                isThreeLine: false,
                                // subtitle: Text(
                                //   '${product.itemCode}',
                                //   style: kTileSubtitleTextStyle,
                                // ),
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${product.itemName}',
                                        style: kTileLeadingTextStyle,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        model.removeQuantity(product);
                                      },
                                      icon: Icon(Icons.remove_circle_outline),
                                    ),
                                    GestureDetector(
                                        child: Container(
                                      width: 25,
                                      child: Text(
                                        model.getQuantity(product).toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                    IconButton(
                                      onPressed: () {
                                        model.addQuantity(product);
                                      },
                                      icon: Icon(Icons.add_circle_outline),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: model.productList.length,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: model.commit,
                            child: Text(
                              'Continue'.toUpperCase(),
                              style: TextStyle(
                                // fontFamily: 'NerisBlack',
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    kColDDSPrimaryDark)),
                          ),
                        )
                      ],
                    )
                  : EmptyContentContainer(label: 'No items found.'),
        );
      },
    );
  }
}
