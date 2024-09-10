import 'package:distributor/ui/widgets/dumb_widgets/text_subheading.dart';
import 'package:distributor/ui/widgets/smart_widgets/customer_summary/customer_summary_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CustomerSummaryWidget extends StatelessWidget {
  final String customerName;
  const CustomerSummaryWidget(this.customerName, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerSummaryViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => model.customer != null
            ? Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubheadingText('Customer'),
                    Text(
                      '${model.customer.name}',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Phone : ${model.customer.telephone}'),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await model.callCustomer();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(Icons.phone),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await model.messageCustomer();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(Icons.message),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Route : ${model.customer.route}'),
                          Text('Branch : ${model.customer.branch}'),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        viewModelBuilder: () => CustomerSummaryViewModel(customerName));
  }
}
