import 'package:distributor/core/enums.dart';
import 'package:distributor/ui/views/manage_crate/manage_crate_viewmodel.dart';
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
        return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Crate Management'),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text('Update'),
                    ),
                    Tab(
                      child: Text('History'),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  GenericContainer(
                    child: ListView(
                      children: [
                        Text(
                            'Select the crate color, action and enter the quantity'),
                        ...model.crateTypes
                            .map(
                              (e) => Card(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            value: model.crates.contains(e),
                                            onChanged: (_) {
                                              model.setCrates(e);
                                            },
                                            title: Text(e.toUpperCase()),
                                          ),
                                        ),
                                        //Limit the quantity to the max quantity based on pickup/dropoff
                                        Container(
                                          width: 50,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration:
                                                InputDecoration(hintText: '0'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: model.crateTxnTypes
                                              .map((e) => Expanded(
                                                    child: RadioListTile(
                                                        value: e,
                                                        title: Row(
                                                          children: [Text(e)],
                                                        ),
                                                        groupValue:
                                                            model.crateTxnType,
                                                        onChanged: (c) {
                                                          model.crateTxnType =
                                                              c;
                                                        }),
                                                  ))
                                              .toList(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        Text('Customer'),
                      ],
                    ),
                  ),
                  Container()
                ],
              ),
            ));
      },
      viewModelBuilder: () => ManageCrateViewModel(
        customer: customer,
        crateTxnType: crateTxnType,
        crateType: crateType,
      ),
    );
  }
}
