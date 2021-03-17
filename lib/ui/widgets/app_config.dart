import 'package:distributor/core/constants/configs.dart';
import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  AppConfig({this.appEnvList});
  final List<AppEnv> appEnvList;

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
