import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ProximityWidget extends StatelessWidget {
  final Fence fence;
  const ProximityWidget({Key key, this.fence}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(' Km');
  }
}
