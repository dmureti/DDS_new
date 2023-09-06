import 'package:device_info_plus/device_info_plus.dart';
import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_version.dart';
import 'package:distributor/services/init_service.dart';
import 'package:distributor/services/version_service.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class AppInfoViewModel extends BaseViewModel {
  final _versionService = locator<VersionService>();
  final _initService = locator<InitService>();

  static const methodChannel = MethodChannel("tech.ddsolutions.app/method");

  static const batteryChannel = EventChannel("tech.ddsolutions.app/battery");

  get version => _versionService.appVersion.versionCode;
  AndroidDeviceInfo get androidDeviceInfo => _initService.androidDeviceInfo;

  String _batteryLevel = "Unknown battery level";
  String _networkStrength = "Unknown Network Strength";

  String get batteryLevel => _batteryLevel;
  String get networkStrength => _networkStrength;

  Future _getNetworkStrength() async {
    try {} catch (e) {}
  }

  Future _getBatteryLevel() async {
    try {
      final int result = await methodChannel.invokeMethod('getBatteryLevel');
      _batteryLevel = "Battery level at $result %";
    } catch (e) {
      _batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    notifyListeners();
  }

  AppVersion _appVersion;
  AppVersion get appVersion => _appVersion;

  init() async {
    await getAppInfo();
    await _initService.fetchDeviceInfo();
  }

  getAppInfo() async {
    setBusy(true);
    _appVersion = await _versionService.getVersion();
    setBusy(false);
    notifyListeners();
  }
}
