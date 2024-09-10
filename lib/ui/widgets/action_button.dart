import 'package:distributor/conf/dds_brand_guide.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final onPressed;
  const ActionButton({Key key, this.label, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    onPressed == null ? Colors.grey : kColDDSPrimaryDark),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                '$label'.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'NerisBlack',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
