import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

class SKUSuggestionTile extends StatelessWidget {
  final Product product;
  final int index;
  const SKUSuggestionTile({Key key, this.product, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.itemName),
    );
  }
}
