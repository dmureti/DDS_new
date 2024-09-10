import 'package:flutter/material.dart';

Widget BusyWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(child: CircularProgressIndicator()),
    ],
  );
}

Widget NoInfoFound({String text}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        child: Text(text),
      ),
    ],
  );
}
