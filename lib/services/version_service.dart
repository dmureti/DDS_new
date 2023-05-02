import 'dart:convert';

import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_version.dart';
import 'package:distributor/services/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VersionService {
  final _firestoreService = locator<FirestoreService>();

  AppVersion _appVersion;
  AppVersion get appVersion => _appVersion;

  String get versionCode => _appVersion.versionCode.toString();
  String get versionName => appVersion.versionName;
  String get remoteUrl => appVersion.remoteUrl;

  // Compare version numbers
  compareVersions(
      {@required AppVersion appVersion1, @required AppVersion appVersion2}) {
    if (appVersion2.buildNumber > appVersion1.buildNumber) {
      return true;
    } else {
      return false;
    }
  }

  downloadAndUpdate() async {}

  VersionService() {
    // getVersion();
  }

  AppVersion _latestVersion;
  AppVersion get latestVersion => _latestVersion;

  Future<AppVersion> checkForUpdates(String tenantId) async {
    print('checking for updates $tenantId');
    var result = await _firestoreService.checkForUpdates(tenantId);
    return result;
  }

  Future<AppVersion> getVersion() async {
    final String response =
        await rootBundle.loadString('assets/docs/version.json');
    _appVersion = AppVersion.fromMap(json.decode(response)['version']);
    return _appVersion;
  }
}
