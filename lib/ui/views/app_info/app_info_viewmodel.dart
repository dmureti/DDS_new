import 'package:device_info_plus/device_info_plus.dart';
import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_version.dart';
import 'package:distributor/services/init_service.dart';
import 'package:distributor/services/version_service.dart';
import 'package:stacked/stacked.dart';

class AppInfoViewModel extends BaseViewModel {
  final _versionService = locator<VersionService>();
  final _initService = locator<InitService>();

  get version => _versionService.appVersion.versionCode;
  AndroidDeviceInfo get androidDeviceInfo => _initService.androidDeviceInfo;

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
