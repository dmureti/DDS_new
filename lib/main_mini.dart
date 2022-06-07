import 'package:distributor/app/locator.dart';

import 'package:distributor/main.dart';
import 'package:distributor/ui/setup_snackbar_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

import 'services/init_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  setupSnackbarUi();
  InitService _initService = locator<InitService>();
  _initService.setAvailableEnvList([
    AppEnv(
      flavor: Flavor.mini,
      name: 'mini',
      flavorValues: FlavorValues(
          baseUrl: 'https://dds.ddsolutions.tech/dds-backend/api/v1'),
    )
  ]);
  runApp(MainApp());
}
