import 'package:distributor/src/ui/views/quotation_view/confirm_quotation_viewmodel.dart';
import 'package:distributor/src/ui/views/quotation_view/quotation_viewmodel.dart';
import 'package:distributor/ui/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ConfirmQuotationView extends StatelessWidget {
  final orderedItems;
  final String customerCode;
  const ConfirmQuotationView({Key key, this.orderedItems, this.customerCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConfirmQuotationViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Confirm Quotation'),
          ),
          body: Column(
            children: [
              Container(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [Text('Customer : $customerCode')],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var item = model.orderedItems[index];
                    return ListTile(
                      leading: Text(item.quantity.toString()),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.itemName),
                          Text((item.quantity * item.itemPrice)
                              .toStringAsFixed(2))
                        ],
                      ),
                      subtitle: Text(item.itemPrice.toStringAsFixed(2)),
                    );
                  },
                  itemCount: model.orderedItems.length,
                ),
              ),
              ActionButton(
                label: 'Generate Quotation',
                onPressed: () => model.generateQuotation(),
              )
            ],
          ),
        );
      },
      viewModelBuilder: () =>
          ConfirmQuotationViewModel(orderedItems, customerCode),
    );
  }
}
