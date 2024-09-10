import 'package:distributor/ui/views/help/help_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class HelpDetailView extends StatelessWidget {
  final String id;
  final String title;
  const HelpDetailView({Key key, this.id, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HelpViewModel>.reactive(
      viewModelBuilder: () => HelpViewModel(),
      onModelReady: (model) => model.fetchDocumentById(id),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                Text('Help'),
              ],
            ),
          ),
          body: GenericContainer(
            child: model.isBusy ? BusyWidget() : ListView(),
          ),
        );
      },
    );
  }
}
