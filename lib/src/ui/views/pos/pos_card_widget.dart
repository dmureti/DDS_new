import 'package:distributor/src/ui/views/pos/shared/outlined_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripletriocore/tripletriocore.dart';

class POSCardWidget extends StatelessWidget {
  final Product item;
  const POSCardWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      child: SizedBox(
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 5 / 3,
                    child: Placeholder(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        item.itemName,
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('Kshs ${item.itemPrice}')),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('0')),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
