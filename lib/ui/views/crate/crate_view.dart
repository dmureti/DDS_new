import 'package:distributor/ui/views/crate/crate_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CrateView extends StatelessWidget {
  const CrateView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CrateViewModel>.reactive(
        onModelReady: (model) => model.init(),
        fireOnModelReadyOnce: false,
        builder: (context, model, child) {
          return model.isBusy
              ? BusyWidget()
              : model.crates.isEmpty
                  ? Center(
                      child:
                          EmptyContentContainer(label: 'You have no crates.'))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        var crate = model.crates[index];
                        return ListTile(
                          onTap: () {
                            model.navigateToManageCrateView();
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(crate.name),
                              Text(crate.count.toString())
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_vert),
                          ),
                        );
                      },
                      itemCount: model.crates.length,
                    );
        },
        viewModelBuilder: () => CrateViewModel());
  }
}
