import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_version.dart';
import 'package:distributor/services/version_service.dart';
import 'package:stacked/stacked.dart';

class AppInfoViewModel extends BaseViewModel {
  final _versionService = locator<VersionService>();

  get version => _versionService.appVersion.versionCode;

  AppVersion _appVersion;
  AppVersion get appVersion => _appVersion;

  init() async {
    await getAppInfo();
  }

  getAppInfo() async {
    setBusy(true);
    _appVersion = await _versionService.getVersion();
    setBusy(false);
    notifyListeners();
  }
}
