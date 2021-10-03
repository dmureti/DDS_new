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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'FR0M : ',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            width: 60,
                          ),
                          Text(
                            transaction.sourceWarehouse,
                          ),
                        ],
                      ),
                      Text(transaction.stockTransactionId,
                          style: kListStyleTitle1),
                    ],
                  ),
                  SizedBox(
                    height: 2,
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
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          subtitle: Row(
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
    );
  }
}
