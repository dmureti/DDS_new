import 'package:distributor/ui/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomModalSheetTitle extends StatelessWidget {
  final String title;
  BottomModalSheetTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                title.toUpperCase(),
                style: kModalBottomSheetTitle,
              ),
            ),
//            Spacer(),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close),
            ),
          ],
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class ReportFieldRow extends StatelessWidget {
  final String field;
  final String value;

  ReportFieldRow({this.field, this.value, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: 140,
            child: Text(
              '$field',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              '$value',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({this.value, this.title, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: kKeyTextStyle,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          value,
          style: kValueTextStyle,
        ),
      ],
    );
  }
}

class FormErrorContainer extends StatelessWidget {
  final String errorMsg;

  FormErrorContainer({this.errorMsg});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 5, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Icon(
            FontAwesomeIcons.exclamationCircle,
            color: Colors.redAccent,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            child: Text(
              errorMsg,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFormFieldPadding extends StatelessWidget {
  final Widget child;

  TextFormFieldPadding({@required this.child, Key key})
      : assert(child != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
      child: child,
    );
  }
}
