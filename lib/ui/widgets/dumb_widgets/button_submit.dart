import 'package:flutter/material.dart';

class ButtonSubmit extends StatelessWidget {
  final String label;
  final Function onPressed;
  final validator;

  const ButtonSubmit({Key key, this.label, this.onPressed, this.validator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(label),
        onPressed: () => onPressed(),
      ),
    );
  }
}
