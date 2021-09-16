import 'package:auto_route/auto_route.dart';
import 'package:distributor/src/ui/views/voucher_detail/voucher_detail_viewmodel.dart';
import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:distributor/ui/shared/widgets.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:distributor/ui/widgets/dumb_widgets/product_quantity_tile.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class VoucherDetailView extends StatelessWidget {
  final String transactionId;
  final String voucherType;

  const VoucherDetailView(
      {Key key, @required this.transactionId, @required this.voucherType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VoucherDetailViewmodel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarColumnTitle(
                mainTitle: 'Voucher Details',
                subTitle: transactionId,
              ),
            ),
            body: Container(
              child: model.stockTransaction == null
                  ? BusyWidget()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownButton(
                                    disabledHint:
                                        Text('Operation not possible'),
                                    isExpanded: true,
                                    value: model.status,
                                    onChanged: model.disableDropdown
                                        ? null
                                        : (String val) {
                                            model.setStatus(val);
                                          },
                                    hint: Text(
                                        'Accept or Cancel this transaction'),
                                    items: model.statusStrings
                                        .map((e) => DropdownMenuItem(
                                              child: Text(e),
                                              value: e,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Material(
                              color: Colors.grey.withOpacity(0.1),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReportFieldRow(
                                        field: 'Status',
                                        value: model.stockTransaction
                                            .transactionStatus),
                                    ReportFieldRow(
                                        field: 'Voucher Type',
                                        value:
                                            model.stockTransaction.voucherType),
                                    ReportFieldRow(
                                        field: 'Voucher Subtype',
                                        value: model
                                            .stockTransaction.voucherSubType),
                                    ReportFieldRow(
                                        field: 'Entry Date',
                                        value:
                                            model.stockTransaction.entryDate),
                                    Text('Remarks'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, left: 15),
                              child: Text(
                                'Items'.toUpperCase(),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          model.stockTransaction.items != null
                              ? Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 8),
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        Product p =
                                            model.stockTransaction.items[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 40,
                                                child: Text(p.itemCode,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: Colors.black54)),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(p.itemName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Colors.black54)),
                                              Spacer(),
                                              Text(
                                                p.quantity.toStringAsFixed(0),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Colors.black87),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount:
                                          model.stockTransaction.items.length,
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: ListView(
                                    children: [
                                      Center(child: Text('No items')),
                                    ],
                                  ),
                                ),
                        ]),
            ),
          );
        },
        viewModelBuilder: () =>
            VoucherDetailViewmodel(transactionId, voucherType));
  }
}
