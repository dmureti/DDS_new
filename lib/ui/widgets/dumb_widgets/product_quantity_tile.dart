import 'package:distributor/src/ui/text_styles.dart';
import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:distributor/ui/widgets/dumb_widgets/product_quantity_container.dart';
import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ProductQuantityTile extends StatelessWidget {
  final Product product;
  const ProductQuantityTile({Key key, @required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        title: Text(
          product.itemName,
          style: kListStyleTitle1,
        ),
        subtitle: Text(
          product.itemCode,
          style: kListStyleSubTitle1,
        ),
        trailing: ProductQuantityContainer(
          quantity: product.quantity.toInt(),
        ),
      ),
    );
  }
}
