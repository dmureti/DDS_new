import 'package:flutter/material.dart';

class DashboardCTAButton extends StatelessWidget {
  final String label;
  final Function onTap;
  const DashboardCTAButton({Key key, @required this.label, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
