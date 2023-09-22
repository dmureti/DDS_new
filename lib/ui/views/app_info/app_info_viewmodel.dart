import 'package:device_info_plus/device_info_plus.dart';
import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_version.dart';
import 'package:distributor/services/init_service.dart';
import 'package:distributor/services/version_service.dart';
// import 'package:feitan_phone/feitan_phone.dart';
// import 'package:feitan/feitan.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class AppInfoViewModel extends BaseViewModel {
  final _versionService = locator<VersionService>();
  final _initService = locator<InitService>();

  static const batteryChannel =
      EventChannel("tripletriolimited.distributor/battery");

  // Feitan feitan = Feitan();

  get version => _versionService.appVersion.versionCode;

  // FeitanPhone feitian = FeitanPhone();

  AndroidDeviceInfo get androidDeviceInfo => _initService.androidDeviceInfo;

  String _batteryLevel = "Unknown battery level";
  String _sensorAvailable = "Unknown";
  String _networkStrength = "Unknown Network Strength";
  String _printerStatus = "Unknown Printer Status";

  String get batteryLevel => _batteryLevel;
  String get networkStrength => _networkStrength;
  String get printerStatus => _printerStatus;
  String get sensorAvailable => _sensorAvailable;

  // Get the printer status
  Future getPrinterStatus() async {
    // try {
    //   var result = await feitian.getPrinterStatus();
    //   print(result);
    //   print("in get printer status $result");
    //   _printerStatus = result.toString();
    // } catch (e) {
    //   _printerStatus = "Unknown status";
    // }
    // notifyListeners();
  }

  Future _getNetworkStrength() async {
    try {} catch (e) {}
  }

  Future getBatteryLevel() async {
    // try {
    //   setBusy(true);
    //   var result = await feitian.getBatteryStatus();
    //   setBusy(false);
    //   _batteryLevel = "Battery level at $result %";
    // } on PlatformException catch (e) {
    //   print(e);
    //   _batteryLevel = "Failed to get battery level: '${e.message}'.";
    // }
    //
    // notifyListeners();
  }

  Future<void> checkSensorAvailability() async {
    // try {
    //   var available = await feitian.getPlatformVersion();
    //   print(available);
    //   _sensorAvailable = available.toString();
    // } catch (e) {
    //   print(e);
    // }
  }

  Future printQRCode() async {
    try {} catch (e) {}
  }

  AppVersion _appVersion;
  AppVersion get appVersion => _appVersion;

  init() async {
    await getAppInfo();
    await _initService.fetchDeviceInfo();
    // await getBatteryLevel();
    await _getNetworkStrength();
    await getPrinterStatus();
  }

  getAppInfo() async {
    setBusy(true);
    _appVersion = await _versionService.getVersion();
    setBusy(false);
    notifyListeners();
  }
}
