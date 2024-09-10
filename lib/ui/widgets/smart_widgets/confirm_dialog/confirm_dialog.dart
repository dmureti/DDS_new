import 'package:distributor/ui/widgets/smart_widgets/confirm_dialog/confirm_dialog_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ConfirmDialog extends StatelessWidget {
  final SalesOrder salesOrder;
  final String stopId;

  const ConfirmDialog(
      {@required this.salesOrder, @required this.stopId, Key key})
      : assert(salesOrder != null, stopId != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConfirmDialogViewModel>.reactive(
        builder: (context, model, child) => Dialog(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'COMPLETE ORDER',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.indigo),
                    ),
                    Divider(),
                    Text(
                        'You are about to close the Sales Order ${model.salesOrder.orderNo} for ${model.salesOrder.customerName}.'),
                    Text(
                        'Confirm that you have delivered all the items on this order first.'),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('I confirm that I have delivered all items.'),
                      value: model.isChecked,
                      onChanged: (bool value) {
                        model.updateIsChecked(value);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.solidWindowClose),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text('Cancel'.toUpperCase()),
                            ],
                          ),
                          onPressed: () async {
                            await Navigator.pop(context, false);
                          },
                        ),
                        model.isBusy
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                child: Row(
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.check),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text('Confirm'.toUpperCase()),
                                  ],
                                ),
                                onPressed: model.isChecked == true
                                    ? () async {
                                        var result =
                                            await model.completeTrip(stopId);
                                        if (result) {
                                          await model.navigateToRoutes();
                                        } else {
                                          model.navigateToRoutes();
                                          model.showFailedMessage();
                                        }
                                      }
                                    : null,
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => ConfirmDialogViewModel(salesOrder: salesOrder));
  }
}
