import 'package:flutter/foundation.dart';

class CrateMovement {
  final String _color;
  num _quantity;
  String _action;

  CrateMovement({@required String crateColor, num quantity, String actionType})
      : _color = crateColor,
        _quantity = quantity ?? 0,
        _action = actionType;

  String get color => _color;
  num get quantity => _quantity ?? 0;
  String get action => _action;

  toJson() {
    return {"color": color, "quantity": quantity, "action": action};
  }
}
