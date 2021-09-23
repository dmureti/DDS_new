import 'package:distributor/src/ui/text_styles.dart';
import 'package:flutter/material.dart';

class ProductQuantityContainer extends StatelessWidget {
  final int quantity;
  final TextStyle style;
  const ProductQuantityContainer(
      {Key key, @required this.quantity, this.style = kCartQuantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      child: Text(
        quantity.toStringAsFixed(0),
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
