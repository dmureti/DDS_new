import 'package:distributor/ui/views/manage_crate/manage_crate_viewmodel.dart';
import 'package:distributor/ui/widgets/crate_return/crate_return_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ManageCrateView extends StatelessWidget {
  final String crateTxnType;
  final String crateType;
  final Customer customer;

  const ManageCrateView(
      {Key key, this.crateTxnType, this.crateType, this.customer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageCrateViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Crate Management'),
          ),
          body: GenericContainer(
            child: ListView(
              children: [
                Text('Select the crate color'),
                ...model.crateTypes
                    .map(
                      (e) => CrateReturnWidget(
                        color: e,
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ManageCrateViewModel(
        customer: customer,
        crateTxnType: crateTxnType,
        crateType: crateType,
      ),
    );
  }
}
