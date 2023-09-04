import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:flutter/material.dart';

class AdhocSaleListTile extends StatelessWidget {
  final AdhocSale adhocSale;
  final Function onTap;
  const AdhocSaleListTile(
      {Key key, @required this.adhocSale, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap(adhocSale.referenceNo, adhocSale.customerId, adhocSale.baseType);
      },
      // isThreeLine: true,
      subtitle: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              child: Text('${adhocSale.referenceNo}',
                  overflow: TextOverflow.ellipsis,
                  style: kTileSubtitleTextStyle),
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
              style: kTileLeadingTextStyle,
            ),
          ),
          Container(
            child: Text(
              '${adhocSale.transactionStatus.toUpperCase()}',
              textAlign: TextAlign.right,
            ),
            width: 100,
          ),
          // Container(
          //   alignment: Alignment.topRight,
          //   child: Text(
          //       '${Helper.formatDate(DateTime.parse(adhocSale.transactionDate))}'),
          // ),
        ],
      ),
    );
  }
}
