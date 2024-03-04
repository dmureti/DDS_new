import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_version.dart';
import 'package:distributor/services/user_service.dart';
import 'package:distributor/services/version_service.dart';
import 'package:stacked/stacked.dart';

class QuotationPrintViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _versionService = locator<VersionService>();

  _getVersion() async {
    setBusy(true);
    await _versionService.getVersion().then((value) async {
      _appVersion = value;
      _versionCode = _appVersion.versionCode.toString();
      // await checkForUpdates();
    });
    setBusy(false);
  }

  AppVersion _appVersion;
  String _versionCode = "";
  String get versionCode => _versionCode;

  QuotationPrintViewModel(this.quotation, this.quotationId);
  get user => _userService.user;

  final quotation;
  final String quotationId;

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

  num net;
  num tax;
  num gross;
  num taxRate = 16;

  String currency = "KES";

  init() async {
    setBusy(true);
    // await fetchDeviceInfo();
    await _getVersion();
    // calculateGrossAmount();
    getCurrentDateTime();
    setBusy(false);
  }
}
