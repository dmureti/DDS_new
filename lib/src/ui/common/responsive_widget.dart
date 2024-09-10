import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget child;
  const ResponsiveWidget({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      child: child,
      maxWidth: 1200,
      minWidth: 480,
      defaultScale: true,
      breakpoints: [
        ResponsiveBreakpoint.resize(480, name: MOBILE),
        ResponsiveBreakpoint.autoScale(800, name: TABLET),
        ResponsiveBreakpoint.resize(1000, name: DESKTOP),
      ],
    );
  }
}
