import 'package:distributor/ui/views/stock_collection/stock_collection_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:distributor/ui/widgets/dumb_widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StockCollectionView extends StatelessWidget {
  final DeliveryStop deliveryStop;
  const StockCollectionView({Key key, @required this.deliveryStop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StockCollectionViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarColumnTitle(
                mainTitle: deliveryStop.stopAtBranchId,
                subTitle: deliveryStop.dependentJourneyId,
              ),
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text('Confirm Collection'),
                        value: 'collect_goods',
                      )
                    ];
                  },
                  onSelected: (x) {
                    model.confirmCollection();
                  },
                )
              ],
            ),
            body: GenericContainer(
              child: model.isBusy
                  ? Center(
                      child: BusyWidget(),
                    )
                  : model.deliveryStop.deliveryItems.isEmpty
                      ? Center(
                          child: EmptyContentContainer(
                              label: 'No items found for this stop'),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            var deliveryItem =
                                model.deliveryStop.deliveryItems[index];
                            return Material(
                              type: MaterialType.card,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      deliveryItem['itemName'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      deliveryItem['quantity'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: model.deliveryStop.deliveryItems.length,
                        ),
            ),
          );
        },
        viewModelBuilder: () => StockCollectionViewModel(deliveryStop));
  }
}
