import 'package:distributor/ui/widgets/quantity_input/quantity_input_view.dart';
import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

class POSCardWidget extends StatelessWidget {
  final Product item;
  const POSCardWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var result = await showDialog(
            context: context,
            builder: (context) {
              return QuantityInput(
                title: 'Enter Quantity',
                minQuantity: 0,
                maxQuantity: 200000,
                description:
                    'How many pcs for ${item.itemName} would you like to order ?',
                initialQuantity: 0,
              );
            });
      },
      child: Card(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 5 / 3,
                        child: Stack(
                          children: [
                            Placeholder(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.itemName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Kshs ${item.itemPrice.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 1.0,
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              'Kshs 0.00',
                              style: TextStyle(fontSize: 13),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
