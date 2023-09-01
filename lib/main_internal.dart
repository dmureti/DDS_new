import 'dart:io';

import 'package:distributor/app/locator.dart';
import 'package:distributor/main.dart';
import 'package:distributor/services/init_service.dart';
import 'package:distributor/ui/setup_snackbar_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripletriocore/tripletriocore.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  setupSnackbarUi();
  InitService _initService = locator<InitService>();
  List<AppEnv> _appEnv = [
    AppEnv(
      flavor: Flavor.internal,
      name: 'Encours',
      flavorValues: FlavorValues(
          baseUrl: 'https://testdds.ddsolutions.tech/spvdev-backend/api/v1'),
    ),
    AppEnv(
      flavor: Flavor.internal,
      name: 'SPV',
      flavorValues: FlavorValues(
          baseUrl: 'https://testdds.ddsolutions.tech/spv-backend/api/v1'),
    ),
    AppEnv(
      flavor: Flavor.internal,
      name: 'Test - Mini-Msa',
      flavorValues: FlavorValues(
          baseUrl: 'https://testdds.ddsolutions.tech/spv-backend/api/v1'),
    ),

    AppEnv(
      flavor: Flavor.internal,
      name: 'Live - Mini-Nairobi',
      flavorValues: FlavorValues(
          baseUrl: 'https://mbnl.ddsolutions.tech/dds-backend/api/v1'),
    ),
    AppEnv(
      flavor: Flavor.internal,
      name: 'Live - Mini-Mombasa',
      flavorValues: FlavorValues(
          baseUrl: 'https://dds.ddsolutions.tech/dds-backend/api/v1'),
    ),
    AppEnv(
      flavor: Flavor.internal,
      name: 'Test - Mini-Uganda',
      flavorValues:
          FlavorValues(baseUrl: 'http://34.252.102.87:8888/dds-backend/api/v1'),
    ),

    // AppEnv(
    //   flavor: Flavor.internal,
    //   name: 'Alpha',
    //   flavorValues: FlavorValues(
    //       baseUrl: 'https://testdds.ddsolutions.tech/alpha-backend/api/v1'),
    // ),
    AppEnv(
      flavor: Flavor.internal,
      name: 'Demo',
      flavorValues:
          FlavorValues(baseUrl: 'http://63.34.178.251:8888/dds-backend/api/v1'),
    ),
  ];
  _initService.setAvailableEnvList(_appEnv);
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(MainApp());
}
