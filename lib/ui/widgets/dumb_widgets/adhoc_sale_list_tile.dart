import 'package:distributor/core/helper.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/src/ui/text_styles.dart';
import 'package:flutter/material.dart';

class AdhocSaleListTile extends StatelessWidget {
  final AdhocSale adhocSale;
  final Function onTap;
  const AdhocSaleListTile(
      {Key key, @required this.adhocSale, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Material(
        type: MaterialType.card,
        elevation: 1.0,
        child: ListTile(
          onTap: () {
            onTap(adhocSale.referenceNo, adhocSale.customerId,
                adhocSale.baseType);
          },
          // isThreeLine: true,
          subtitle: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text('${adhocSale.baseType}'),
                  width: 100,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.black26),
                //     borderRadius: BorderRadius.circular(2),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(4.0),
                //     child: Text(
                //       '${adhocSale.transactionStatus.toUpperCase()}',
                //       style: TextStyle(fontSize: 12),
                //     ),
                //   ),
                // ),
                Text('Kshs ${adhocSale.total.toStringAsFixed(2)}'),
              ],
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 90,
                child: Text(
                  '${adhocSale.referenceNo}',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
              Container(
                width: 180,
                child: Text(
                  '${adhocSale.customerName}',
                  overflow: TextOverflow.ellipsis,
                  style: kListStyleTitle1,
                ),
              ),
              Container(
                child: Text(
                    '${Helper.formatDateShort(DateTime.parse(adhocSale.transactionDate))}'),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
