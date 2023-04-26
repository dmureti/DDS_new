import 'package:injectable/injectable.dart';
// import 'package:package_info_plus/package_info_plus.dart';

@lazySingleton
class VersionService {
  String get version => '14.0.2';
  // PackageInfo _packageInfo = PackageInfo(
  //   appName: 'Unknown',
  //   packageName: 'Unknown',
  //   version: 'Unknown',K
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

  getVersion() async {
    // _packageInfo = await PackageInfo.fromPlatform();
  }
}
