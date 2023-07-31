import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/src/ui/common/sale_format.dart';
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
                  child: Text('${adhocSale.transactionStatus.toUpperCase()}'),
                  width: 100,
                ),
                Text(
                  'Kshs ${adhocSale.total.toStringAsFixed(2)}',
                  style: TextStyle(),
                ),
              ],
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 180,
                child: Text(
                  '${adhocSale.customerName}',
                  overflow: TextOverflow.ellipsis,
                  style: kListStyleTitle1,
                ),
              ),
              Container(
                width: 100,
                child: Text(
                  '${adhocSale.referenceNo}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13, color: formatSale(adhocSale.baseType)),
                ),
              ),
              // Container(
              //   alignment: Alignment.topRight,
              //   child: Text(
              //       '${Helper.formatDate(DateTime.parse(adhocSale.transactionDate))}'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
