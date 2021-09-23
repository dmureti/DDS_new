import 'package:distributor/core/helper.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/src/ui/text_styles.dart';
import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final Function onTap;
  const TransactionTile(this.transaction, {Key key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Material(
        elevation: 1,
        type: MaterialType.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: ListTile(
          onTap: onTap,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    child: Text('FR0M : '),
                    width: 50,
                  ),
                  Text(
                    transaction.sourceWarehouse,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Text('TO :'),
                    width: 50,
                  ),
                  Text(
                    transaction.destinationWarehouse,
                  ),
                ],
              ),
            ],
          ),
          leading:
              Text(transaction.stockTransactionId, style: kListStyleTitle1),
          subtitle: Row(
            children: [
              Text(
                transaction.voucherType.toUpperCase(),
                style: kListStyleSubTitle1,
              ),
              Text(
                transaction.voucherSubType,
                style: kListStyleSubTitle2,
              ),
              Spacer(),
              Text(transaction.transactionStatus.toUpperCase()),
            ],
          ),
        ),
      ),
    );
  }
}
