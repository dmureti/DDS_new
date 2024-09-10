import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/src/ui/text_styles.dart';
import 'package:flutter/material.dart';

class ProductQuantityContainer extends StatelessWidget {
  final int quantity;
  final TextStyle style;
  final TextStyle secondaryStyle;
  const ProductQuantityContainer(
      {Key key,
      @required this.quantity,
      this.style = kCartQuantity,
      this.secondaryStyle = kCartSecondaryStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      child: Text(
        quantity.toStringAsFixed(0),
        style: quantity > 0 ? secondaryStyle : style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
