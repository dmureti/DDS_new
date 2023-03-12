import 'package:distributor/ui/views/territory/territory_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:distributor/ui/widgets/dumb_widgets/generic_container.dart';
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
          ),
          body: GenericContainer(
            child: model.fenceList.isEmpty
                ? Center(
                    child: EmptyContentContainer(
                        label: 'You have not been assigned any territories.'),
                  )
                : Expanded(
                    child: ListView.builder(
                    itemBuilder: (context, index) {
                      var fence = model.fenceList[index];
                      return ListTile(
                        onTap: () => model.navigateToTerritoryDetail(fence),
                        title: Text(fence.name),
                      );
                    },
                    itemCount: model.fenceList.length,
                  )),
          ),
        );
      },
      viewModelBuilder: () => TerritoryViewModel(),
    );
  }
}
