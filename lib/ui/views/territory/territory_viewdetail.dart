import 'package:distributor/ui/views/territory/territory_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class TerritoryDetailView extends StatelessWidget {
  final Fence fence;
  const TerritoryDetailView({Key key, this.fence}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TerritoryDetailViewModel>.reactive(
        builder: (BuildContext, model, Widget) {
          return Scaffold(
            appBar: AppBar(
              title: Text(model.fence.name.toUpperCase()),
            ),
          );
        },
        viewModelBuilder: () => TerritoryDetailViewModel(fence));
  }
}
