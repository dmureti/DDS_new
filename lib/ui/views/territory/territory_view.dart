import 'package:distributor/ui/views/territory/territory_viewmodel.dart';
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
          appBar: AppBar(),
          body: GenericContainer(
            child: Column(),
          ),
        );
      },
      viewModelBuilder: () => TerritoryViewModel(),
    );
  }
}
