import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/src/ui/text_styles.dart';
import 'package:flutter/material.dart';

class EmptyContentContainer extends StatelessWidget {
  final String label;
  const EmptyContentContainer({Key key, @required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        label,
        style: kCommentTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
