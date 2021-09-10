import 'package:distributor/core/models/app_models.dart';
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
          title: Text(
            transaction.stockTransactionId,
            style: TextStyle(
                color: kDarkBlue, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            transaction.voucherType,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 12, color: kLightBlue),
          ),
          trailing: Text(transaction.transactionStatus),
        ),
      ),
    );
  }
}
