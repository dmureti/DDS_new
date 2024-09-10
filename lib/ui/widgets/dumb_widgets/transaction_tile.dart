import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/core/helper.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/src/ui/text_styles.dart';
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
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'FR0M : ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                transaction.sourceWarehouse,
                                style: kTileLeadingTextStyle,
                              ),
                              Text(
                                transaction.stockTransactionId,
                                // textAlign: TextAlign.right,
                                style: kTileLeadingSecondaryTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            'TO :',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          width: 60,
                        ),
                        Text(
                          transaction.destinationWarehouse,
                          style: kTileLeadingTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Text(Helper.formatDate(DateTime.parse(transaction.entryDate)),
                    style: kListStyleSubTitle1),
                Spacer(),
                Text(
                  transaction.voucherType.toUpperCase(),
                  style: kListStyleSubTitle1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
