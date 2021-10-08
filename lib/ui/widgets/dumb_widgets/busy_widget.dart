import 'package:flutter/material.dart';

class BusyWidget extends StatelessWidget {
  const BusyWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      child: Center(
        child: Stack(
          children: [
            CircularProgressIndicator(),
            Image.asset(
              'assets/images/mini_logo.png',
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
