import 'package:injectable/injectable.dart';
// import 'package:package_info_plus/package_info_plus.dart';

@lazySingleton
class VersionService {
  // PackageInfo _packageInfo = PackageInfo(
  //   appName: 'Unknown',
  //   packageName: 'Unknown',
  //   version: 'Unknown',
  //   buildNumber: 'Unknown',
  // );

  VersionService() {
    getVersion();
  }

  // PackageInfo get packageInfo => _packageInfo;
  //

  // String get appName => packageInfo.appName;
  // String get packageName => packageInfo.packageName;
  // String get version => packageInfo.version;
  // String get buildNumber => packageInfo.buildNumber;

  String get version => '9.00.4';

  getVersion() async {
    // _packageInfo = await PackageInfo.fromPlatform();
  }
}
