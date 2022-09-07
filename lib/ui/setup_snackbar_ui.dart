import 'package:distributor/conf/style/lib/colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(
    SnackbarConfig(
        backgroundColor: kColorDDSPrimaryDark,
        textColor: kColorNeutral,
        messageColor: kColorNeutral,
        icon: Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        titleColor: kColorNeutral,
        mainButtonTextColor: kColorNeutral),
  );
}
