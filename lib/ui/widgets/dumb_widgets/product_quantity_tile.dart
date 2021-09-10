import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ProductQuantityTile extends StatelessWidget {
  final Product product;
  const ProductQuantityTile({Key key, @required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 1,
        type: MaterialType.card,
        child: ListTile(
          title: Text(
            product.itemName,
            style: TextStyle(
                color: kDarkBlue, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            product.itemCode,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 12, color: kLightBlue),
          ),
          trailing: Text(product.quantity.toStringAsFixed(0)),
        ),
      ),
    );
  }
}
