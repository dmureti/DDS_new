import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:distributor/ui/views/customer_location.dart';
import 'package:distributor/ui/views/customers/customer_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';

import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerListWidget extends HookViewModelWidget<CustomerViewModel> {
  CustomerListWidget({Key key, reactive: true}) : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, CustomerViewModel model) {
    return model.customerList.length == 0
        ? NoInfoFound(text: 'No customers found.')
        : CustomerList(
            customerList: model.listOfCustomers,
            onTap: model.navigateToCustomer);
  }
}

Widget CustomerList({List<Customer> customerList, Function onTap}) {
  return ListView.builder(
      itemCount: customerList.length,
      itemBuilder: (context, index) {
        Customer customer = customerList[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 3,
            type: MaterialType.card,
            child: ListTile(
              trailing: Container(
                width: 60,
                height: 60,
                child: ClipOval(
                  child: InkWell(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: (context),
                        builder: (context) => Container(
                          color: Colors.white,
                          padding:
                              EdgeInsets.only(bottom: 40, left: 20, right: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    color: kDarkBlue,
                                    iconSize: 25,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                ],
                              ),
                              ListTile(
                                leading: Icon(Icons.phone),
                                title: Text('Call'),
                                onTap: () async {
                                  var result =
                                      await launch('tel:${customer.telephone}');
                                  Navigator.pop(context, result);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.message),
                                title: Text('Send SMS'),
                                onTap: () async {
                                  var result =
                                      await launch('sms:${customer.telephone}');
                                  Navigator.pop(context, result);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.location_on),
                                title: Text('Location'),
                                onTap: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => CustomerLocation(
                                              customer: customer,
                                            ),
                                        fullscreenDialog: false),
                                  );
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    splashColor: Colors.pink,
                    child: Material(
                      color: kLightestBlue,
                      type: MaterialType.button,
                      elevation: 4,
                      shadowColor: kLightBlue,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(Icons.contacts),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                onTap(customer);
              },
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '${customer.name}',
                  style: TextStyle(
                      color: kDarkBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Text(
                      'ROUTE',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${customer.route}'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: kLightBlue),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
