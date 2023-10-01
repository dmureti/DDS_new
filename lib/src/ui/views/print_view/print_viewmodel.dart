import 'package:device_info_plus/device_info_plus.dart';
import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_version.dart';
import 'package:distributor/services/init_service.dart';
import 'package:distributor/services/version_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

enum SummaryAmount { Net, Tax, Gross }

enum TaxCategory { Net, Tax, Gross }

class PrintViewModel extends BaseViewModel {
  final InitService _initService = locator<InitService>();
  final _versionService = locator<VersionService>();

  AppEnv get appEnv => _initService.appEnv;
  FlavorValues get flavourValues => appEnv.flavorValues;

  double get taxRate => flavourValues.applicationParameter.taxRate;
  String get currency => flavourValues.applicationParameter.currency;

  DateTime _dateTime;
  String _date = "";
  String _time = "";

  DateTime get dateTime => DateTime.now();

  getCurrentDateTime() {
    _dateTime = DateTime.now();
    var day = _dateTime.day.toString();
    var month = _dateTime.month.toString();
    var year = _dateTime.year.toString();
    _date = "$day - $month- $year";
    notifyListeners();
  }

  String get getTime => _time;
  String get getDate => _date;

  calculateAmounts(SummaryAmount summaryAmount) {
    switch (summaryAmount) {
      case SummaryAmount.Net:
        break;
      case SummaryAmount.Tax:
        break;
      case SummaryAmount.Gross:
        break;
    }
  }

  calculateTax(TaxCategory taxCategory) {
    switch (taxCategory) {
      case TaxCategory.Net:
        break;
      case TaxCategory.Tax:
        break;
      case TaxCategory.Gross:
        break;
    }
  }

  DeviceInfoPlugin _deviceInfo;

  PrintViewModel(this.deliveryNote);
  DeviceInfoPlugin get deviceInfo => _deviceInfo;

  final deliveryNote;

  AndroidDeviceInfo get androidDeviceInfo => _initService.androidDeviceInfo;

  AppVersion _appVersion;
  String _versionCode = "";

  AppVersion get appVersion => _appVersion;

  String get deviceId => androidDeviceInfo.androidId ?? "";
  String get versionCode => _versionCode;

  _getVersion() async {
    setBusy(true);
    await _versionService.getVersion().then((value) async {
      _appVersion = value;
      _versionCode = _appVersion.versionCode.toString();
      // await checkForUpdates();
    });
    setBusy(false);
  }

  init() async {
    setBusy(true);
    await fetchDeviceInfo();
    await _getVersion();
    calculateGrossAmount();
    getCurrentDateTime();
    setBusy(false);
  }

  num _grossAmount = 0.0;
  num get grossAmount => _grossAmount;

  calculateGrossAmount() {
    List deliveryItems = deliveryNote.deliveryItems;
    for (int i = 0; i < deliveryItems.length; i++) {
      var unitSum = deliveryItems[i]['itemRate'] * deliveryItems[i]['quantity'];
      _grossAmount = unitSum + grossAmount;
      notifyListeners();
    }
    _taxAmount = taxRate * grossAmount;
  }

  num _taxAmount = 0;
  num get taxAmount => _taxAmount;

  num get netAmount => grossAmount - _taxAmount;

  fetchDeviceInfo() async {
    setBusy(true);
    setBusy(false);
  }

  drawQRCode() async {}

  // Image _image;
  // Image get image => _image;

  fetchLogo() async {}
}
