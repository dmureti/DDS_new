import 'package:distributor/ui/views/help/help_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HelpView extends StatelessWidget {
  const HelpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HelpViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, builder) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Help'),
            ),
            body: model.isBusy
                ? Center(child: BusyWidget())
                : Container(
                    child: model.items.isEmpty
                        ? Center(
                            child:
                                EmptyContentContainer(label: 'No Help found'))
                        : ListView.builder(
                            itemBuilder: (context, index) => ListTile(
                              title: Text(model.items[index]['title']),
                              onTap: () {
                                model.navigateToDetail(model.items[index]['id'],
                                    model.items[index]['id']);
                              },
                              trailing: IconButton(
                                icon: Icon(Icons.chevron_right),
                                onPressed: () => null,
                              ),
                            ),
                            itemCount: model.items.length,
                          ),
                  ),
          );
        },
        viewModelBuilder: () => HelpViewModel());
  }
}
