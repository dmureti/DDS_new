import 'package:distributor/app/locator.dart';

import 'package:distributor/main.dart';
import 'package:distributor/services/init_service.dart';
import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  InitService _initService = locator<InitService>();
  List<AppEnv> _appEnv = [
    AppEnv(
      flavor: Flavor.internal,
      name: 'Development',
      flavorValues: FlavorValues(
          baseUrl: 'https://testdds.ddsolutions.tech/spvdev-backend/api/v1'),
    ),
    AppEnv(
      flavor: Flavor.internal,
      name: 'SIT',
      flavorValues: FlavorValues(
          baseUrl: 'https://testdds.ddsolutions.tech/spv-backend/api/v1'),
    ),
    AppEnv(
      flavor: Flavor.internal,
      name: 'Mini',
      flavorValues: FlavorValues(
          baseUrl: 'https://testdds.ddsolutions.tech/dds-backend/api/v1'),
    ),
  ];
  _initService.setAvailableEnvList(_appEnv);

  runApp(MainApp());
}
