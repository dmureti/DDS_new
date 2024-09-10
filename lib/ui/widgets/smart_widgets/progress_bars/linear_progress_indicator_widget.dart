import 'package:flutter/material.dart';

class LinearProgressIndicatorWidget extends StatelessWidget {
  final double progressValue;
  const LinearProgressIndicatorWidget({Key key, this.progressValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          backgroundColor: Colors.white,
          value: progressValue.round() / 100,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
        Text(
          '${(progressValue).round()}%',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
