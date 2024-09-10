import 'package:distributor/ui/views/territory/territory_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:distributor/ui/widgets/dumb_widgets/generic_container.dart';
import 'package:distributor/ui/widgets/reactive/territory_tile/territory_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TerritoryView extends StatelessWidget {
  const TerritoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TerritoryViewModel>.reactive(
      builder: (BuildContext, model, Widget) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Territories'),
            actions: [
              Icon(Icons.search),
              Icon(Icons.refresh),
              Icon(Icons.more_vert),
            ],
          ),
          body: GenericContainer(
            child: model.fenceList.isEmpty
                ? Center(
                    child: EmptyContentContainer(
                        label: 'You have not been assigned any territories.'),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      var fence = model.fenceList[index];
                      return TerritoryTileWidget(
                        fence: fence,
                      );
                    },
                    itemCount: model.fenceList.length,
                  ),
          ),
        );
      },
      viewModelBuilder: () => TerritoryViewModel(),
    );
  }
}
