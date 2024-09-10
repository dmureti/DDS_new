import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

class SalesOrderRequestItemWidget extends StatelessWidget {
  final SalesOrderRequestItem salesOrderRequestItem;
  SalesOrderRequestItemWidget(this.salesOrderRequestItem, {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Material(
        type: MaterialType.card,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            leading: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${salesOrderRequestItem.itemCode}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    '${salesOrderRequestItem.quantity}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    // textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            title: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${salesOrderRequestItem.itemName}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                          'Delivered : ${salesOrderRequestItem.quantityDelivered}'),
                    ],
                  ),
                ],
              ),
            ),
            trailing: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    salesOrderRequestItem.itemRate.toStringAsFixed(2),
                    // textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
