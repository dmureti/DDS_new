import 'package:distributor/core/enums.dart';
import 'package:distributor/ui/views/crate_movement/crate_movement_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:distributor/ui/widgets/dumb_widgets/generic_container.dart';
import 'package:distributor/ui/widgets/smart_widgets/customer_text_input/customer_textinput.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CrateMovementView extends StatelessWidget {
  final CrateTxnType crateTxnType;
  final DeliveryStop deliveryStop;
  final Customer customer;
  const CrateMovementView(
      {Key key, this.crateTxnType, this.customer, this.deliveryStop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CrateMovementViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                _buildTitle(crateTxnType),
              ),
            ),
            body: GenericContainer(
              child: model.isBusy
                  ? Center(child: BusyWidget())
                  : Column(
                      children: [
                        Text(
                          _buildLead(crateTxnType),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                        Divider(),
                        deliveryStop != null &&
                                crateTxnType == CrateTxnType.Return
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Customer : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      deliveryStop.customerId,
                                      style: TextStyle(),
                                    ),
                                  ],
                                ),
                              )
                            : crateTxnType == CrateTxnType.Return
                                ? Container()
                                : Row(
                                    children: [
                                      Text(
                                        'Customer Name : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Expanded(
                                        child: CustomerTextInput(
                                            customerList: model.customerList,
                                            onSelected: model.setCustomer),
                                      ),
                                    ],
                                  ),
                        Divider(),
                        model.crateList.isEmpty
                            ? EmptyContentContainer(label: 'No items found')
                            : Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    var crate = model.crateList[index];
                                    return Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                crate.itemName,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(crate.itemCode),
                                            ],
                                          ),
                                          Container(
                                            width: 70,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: TextFormField(
                                                style: TextStyle(fontSize: 16),
                                                textAlign: TextAlign.center,
                                                initialValue:
                                                    model.disableTextFormField
                                                        ? '0'
                                                        : crate.quantity
                                                            .toStringAsFixed(0),
                                                enabled:
                                                    model.disableTextFormField,
                                                onChanged: (val) {
                                                  model.updateItemSet(
                                                      val, crate);
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context)
                                                      .nextFocus();
                                                },
                                                onFieldSubmitted: (val) {
                                                  // Check if this item exists
                                                  model.updateItemSet(
                                                      val, crate);
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: model.crateList.length,
                                ),
                              ),
                        model.isBusy
                            ? Center(
                                child: BusyWidget(),
                              )
                            : RaisedButton(
                                color: Colors.orange,
                                onPressed: !model.isReturn
                                    ? model.commitReturnCrates
                                    : model.isValid == true
                                        ? model.commitChanges
                                        : null,
                                child: Text(
                                  'UPDATE',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                      ],
                    ),
            ),
          );
        },
        viewModelBuilder: () =>
            CrateMovementViewModel(deliveryStop, crateTxnType));
  }

  _buildTitle(CrateTxnType crateTxnType) {
    switch (crateTxnType) {
      case CrateTxnType.Drop:
        return 'Leave Crates with Customer';

      case CrateTxnType.Pickup:
        return 'Collect Crates From Customer';

      case CrateTxnType.Return:
        return 'Return Crates To Warehouse';
      default:
        return 'Collect / Drop Crates';
    }
  }

  _buildLead(CrateTxnType crateTxnType) {
    switch (crateTxnType) {
      case CrateTxnType.Drop:
        return 'Enter the number of crates that have left behind with the customer.';

      case CrateTxnType.Pickup:
        return 'Enter the number of crates that you have collected from the customer.';

      case CrateTxnType.Return:
        return 'Confirm that these are the number of crates you have in stock. You cannot edit the quantity.';
      default:
        return 'Select the crate, action and the quantity.';
    }
  }
}
