import 'dart:io';

import 'package:distributor/app/locator.dart';
import 'package:distributor/firebase_options.dart';
import 'package:distributor/main.dart';
import 'package:distributor/ui/setup_snackbar_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripletriocore/tripletriocore.dart';

import 'services/init_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => print(value.name));
  setupLocator();
  setupSnackbarUi();
  InitService _initService = locator<InitService>();

  // Set the application parameters
  ApplicationParameter appParam = ApplicationParameter(
      enableOfflineService: false,
      enableFullDelivery: false,
      enforceCreditLimit: false,
      enableCustomDelivery: true,
      currency: "KES",
      taxRate: 0.16,
      enableReceivedReturns: true,
      defaultPriceList: "walk in",
      enforceCustomerSecurity: false,
      enableAdhocSales: true,
      enableWalkIn: true,
      enablePrintingService: true,
      enableContractCustomers: true);

  _initService.setAvailableEnvList([
    AppEnv(
      flavor: Flavor.fourSum,
      name: '4Sum',
      flavorValues: FlavorValues(
          // https://4sum.ddsolutions.tech/spvdev-backend/api/v1/
          //baseUrl: 'https://4sum.ddsolutions.tech/spvdev-backend/api/v1',
          // baseUrl: 'https://testdds.ddsolutions.tech/dds-backend/api/v1',
          baseUrl: 'https://4sum.ddsolutions.tech/dds-backend/api/v1',
          applicationParameter: appParam),
    )
  ]);
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(MainApp());
}
