import 'package:distributor/app/locator.dart';
import 'package:distributor/services/version_service.dart';
import 'package:stacked/stacked.dart';

class AppInfoViewModel extends BaseViewModel {
  final _versionService = locator<VersionService>();

  get version => _versionService.version;
}
