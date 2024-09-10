import 'package:flutter/material.dart';

class FlatButtonWidget extends StatelessWidget {
  final String label;
  final Color color;
  final Function onTap;

  const FlatButtonWidget(
      {Key key,
      @required this.label,
      this.color = const Color(0xFFed1c24),
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: onTap),
      ),
    );
  }
}
