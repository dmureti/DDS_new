import 'package:flutter/material.dart';

class SearchContainer extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  SearchContainer({this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: TextField(
        controller: controller,
        decoration:
            InputDecoration(hintText: hintText, prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
