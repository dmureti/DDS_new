import 'package:distributor/ui/widgets/crate_return/crate_return_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CrateReturnWidget extends StatelessWidget {
  final String color;
  final num quantity;
  final String action;
  const CrateReturnWidget({Key key, this.color, this.quantity, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CrateReturnViewModel>.reactive(
        builder: (context, model, child) {
          return Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: model.showElement,
                        onChanged: (val) {
                          model.showElement = val;
                        },
                        title: Text(color),
                      ),
                    ),
                    //Limit the quantity to the max quantity based on pickup/dropoff
                    Container(
                      width: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: '0'),
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
                                    groupValue: model.crateTxnType,
                                    onChanged: (c) {
                                      model.crateTxnType = c;
                                    }),
                              ))
                          .toList(),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        viewModelBuilder: () => CrateReturnViewModel());
  }
}
