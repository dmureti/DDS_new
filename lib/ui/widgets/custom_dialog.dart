import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, subtitle, buttonText;
  final List<String> description;

  CustomDialog({this.title, this.subtitle, this.description, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 1.0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.0),
                ListView.builder(
                  itemCount: description.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      description[index] + '.',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo)),
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    icon: Icon(Icons.close),
                    label: Text(buttonText.toUpperCase()),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
