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
            onTap(adhocSale.referenceNo);
          },
          isThreeLine: true,
          subtitle: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  child: Text('${adhocSale.baseType}'),
                  width: 100,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Kshs ${adhocSale.total.toStringAsFixed(2)}'),
              ],
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${adhocSale.referenceNo}',
                    style: kListStyleTitle2,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${adhocSale.customerName}',
                    style: kListStyleTitle1,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${adhocSale.transactionStatus.toUpperCase()}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
