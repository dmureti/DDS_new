import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopNameWidget extends StatelessWidget {
  final String storeName;
  const ShopNameWidget({Key key, @required this.storeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        storeName,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
