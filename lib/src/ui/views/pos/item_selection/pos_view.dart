import 'package:distributor/src/ui/views/pos/pos_card_widget.dart';
import 'package:distributor/src/ui/views/pos/item_selection/pos_viewmodel.dart';
import 'package:distributor/src/ui/views/pos/shared/clickable.dart';
import 'package:distributor/src/ui/views/pos/shared/image_clipper.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class POSView extends StatelessWidget {
  const POSView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<POSViewmodel>.reactive(
      viewModelBuilder: () => POSViewmodel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Make New Sale'),
            actions: [
              IconButton(
                  onPressed: model.navigateToCart,
                  icon: Icon(Icons.shopping_cart))
            ],
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: model.search, icon: Icon(Icons.search)),
                  IconButton(onPressed: model.sort, icon: Icon(Icons.sort)),
                  IconButton(
                      onPressed: model.vert, icon: Icon(Icons.more_vert)),
                  IconButton(
                    onPressed: model.toggleView,
                    icon: Icon(
                      Icons.list,
                      color: model.isToggled ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
              model.isBusy
                  ? BusyWidget()
                  : Expanded(
                      child: model.isToggled
                          ? ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Clickable(
                                    onTap: () => model.navigateToCart(),
                                    child: SizedBox(
                                      height: 200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ClippedImage(
                                            'playlist.cover.image',
                                            width: 50,
                                            height: 200,
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: buildDetails(
                                                    context,
                                                    Item(
                                                        name: 'test',
                                                        itemCode: '2300')),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 150),
                                itemBuilder: (context, index) {
                                  var item = model.items[index];
                                  return POSCardWidget(
                                    item: item,
                                  );
                                },
                                itemCount: model.items.length,
                                scrollDirection: Axis.vertical,
                              ),
                            ),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDetails(BuildContext context, var item) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text(
              item.name,
              style: context.textTheme.titleSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(item.itemCode,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
