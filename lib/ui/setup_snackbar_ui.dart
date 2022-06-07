import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: Colors.green,
    textColor: Colors.white,
    mainButtonTextColor: Colors.black,
  ));
}
