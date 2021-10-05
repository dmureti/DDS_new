import 'package:distributor/ui/config/brand.dart';
import 'package:flutter/material.dart';

class DetailWidget extends StatefulWidget {
  final int data;
  const DetailWidget({Key key, @required this.data}) : super(key: key);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDarkNeutral20,
      child: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
