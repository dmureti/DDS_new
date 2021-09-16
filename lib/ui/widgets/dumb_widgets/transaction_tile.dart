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
          title: Text(transaction.stockTransactionId, style: kListStyleTitle1),
          leading: Text(Helper.getDay(transaction.entryDate)),
          subtitle: Row(
            children: [
              Text(
                transaction.voucherType.toUpperCase(),
                style: kListStyleSubTitle1,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                transaction.voucherSubType,
                style: kListStyleSubTitle2,
              ),
            ],
          ),
          trailing: Text(transaction.transactionStatus),
        ),
      ),
    );
  }
}
