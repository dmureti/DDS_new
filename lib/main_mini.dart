import 'package:distributor/app/locator.dart';

import 'package:distributor/main.dart';
import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

import 'services/init_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  InitService _initService = locator<InitService>();
  _initService.setAvailableEnvList([
    AppEnv(
      flavor: Flavor.mini,
      name: 'mini',
      flavorValues: FlavorValues(
          baseUrl: 'https://testdds.ddsolutions.tech/dds-backend/api/v1'),
    )
  ]);
  runApp(MainApp());
}
