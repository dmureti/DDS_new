import 'package:device_info_plus/device_info_plus.dart';
import 'package:distributor/app/locator.dart';
import 'package:distributor/services/init_service.dart';
import 'package:stacked/stacked.dart';

enum SummaryAmount { Net, Tax, Gross }

enum TaxCategory { Net, Tax, Gross }

class PrintViewModel extends BaseViewModel {
  final _initService = locator<InitService>();

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

  init() async {
    setBusy(true);
    await fetchDeviceInfo();
    calculateGrossAmount();
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
    // deliveryItems.forEach((element) {
    //   var unitSum = element['itemRate'] * element['quantity'];
    //   total += unitSum;
    // });
    // _grossAmount = total;
    _taxAmount = 0.18 * grossAmount;
  }

  num _taxAmount = 0;
  num get taxAmount => _taxAmount;

  get netAmount => grossAmount - _taxAmount;

  fetchDeviceInfo() async {
    setBusy(true);
    setBusy(false);
  }

  drawQRCode() async {}

  // Image _image;
  // Image get image => _image;

  fetchLogo() async {}
}
