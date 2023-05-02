import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_version.dart';
import 'package:distributor/services/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class VersionService {
  final _firestoreService = locator<FirestoreService>();
  final _dialogService = locator<DialogService>();

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

  // Controller for the download progress stream
  final StreamController<double> _downloadProgressController =
      StreamController<double>();

  // Public feedback stream to be consumed in model
  Stream<double> get downloadProgress => _downloadProgressController.stream;

  getProgressFromStream(int downloaded, int contentLength) {
    return downloaded / contentLength * 100;
  }

  int _contentLength;
  int get contentLength => _contentLength;

  downloadAndUpdate(String remoteUrl) async {
    var httpClient = http.Client();
    var request = new http.Request('GET', Uri.parse(remoteUrl));

    var response = httpClient.send(request);

    String dir = (await getApplicationDocumentsDirectory()).path;
    List<List<int>> chunks = new List();
    int downloaded = 0;
    response.asStream().listen((http.StreamedResponse r) {
      r.stream.listen((List<int> chunk) {
        // Display percentage of completion
        _downloadProgressController
            .add(getProgressFromStream(downloaded, r.contentLength));
        // debugPrint(
        //     'downloadPercentage: ${getProgressFromStream(downloaded, r.contentLength)}');
        chunks.add(chunk);
        downloaded += chunk.length;
        _contentLength = r.contentLength;
      }, onDone: () async {
        // Display percentage of completion
        // debugPrint('downloadPercentage: ${downloaded / r.contentLength * 100}');
        // Save the file
        File file = new File('$dir/demo.apk');
        print('$dir/demo.apk');
        final Uint8List bytes = Uint8List(r.contentLength);
        int offset = 0;
        for (List<int> chunk in chunks) {
          bytes.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }
        await file.writeAsBytes(bytes);
        var dialogResponse = await _dialogService.showConfirmationDialog(
            title: 'Download Complete', confirmationTitle: 'Install');
        if (dialogResponse.confirmed) {
          await openFile();
        }
        return;
      });
    });
  }

  openFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    final File file = File('$dir/demo.apk');
    await file.readAsBytes();
  }

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
