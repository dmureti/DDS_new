import 'package:distributor/core/models/_SalesOrderRequest.dart';
import 'package:distributor/ui/widgets/smart_widgets/sales_order_data_tab;e/sales_order_data_table_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SalesOrderDataTable extends StatelessWidget {
  final SalesOrderRequestItem salesOrderRequestItem;

  SalesOrderDataTable({this.salesOrderRequestItem, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesOrderDataTableViewModel>.reactive(
        builder: (context, model, child) => DataTable(
              columns: [
                DataColumn(label: Text('Particulars')),
                DataColumn(label: Text('Pending')),
                DataColumn(label: Text('Ordered')),
                DataColumn(label: Text('Edit'))
              ],
              rows: [
                DataRow(cells: [
                  DataCell(
                    Text(''),
                  ),
                  DataCell(
                    Text(''),
                  ),
                  DataCell(
                    Text(''),
                  ),
                  DataCell(
                    Text(''),
                  ),
                ]),
                DataRow(cells: [
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                ]),
                DataRow(cells: [
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                ]),
              ],
            ),
        viewModelBuilder: () => SalesOrderDataTableViewModel());
  }
}
