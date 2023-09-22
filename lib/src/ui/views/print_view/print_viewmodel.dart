import 'package:device_info_plus/device_info_plus.dart';
import 'package:distributor/app/locator.dart';
import 'package:distributor/services/init_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class PrintViewModel extends BaseViewModel {
  final _initService = locator<InitService>();

  DeviceInfoPlugin _deviceInfo;

  PrintViewModel(this.deliveryNote);
  DeviceInfoPlugin get deviceInfo => _deviceInfo;

  final DeliveryNote deliveryNote;

  init() async {
    setBusy(true);
    await Future.delayed(Duration(seconds: 4));
    await fetchLogo();
    await fetchDeviceInfo();
    await drawQRCode();
    setBusy(false);
  }

  fetchDeviceInfo() async {
    setBusy(true);
    setBusy(false);
  }

  drawQRCode() async {}

  // Image _image;
  // Image get image => _image;

  fetchLogo() async {}
}
