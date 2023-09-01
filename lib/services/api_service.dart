// This is a helper class for the API
// Using for refactor
import 'package:distributor/app/locator.dart';
import 'package:distributor/services/init_service.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ApiService {
  InitService _initService = locator<InitService>();
  AppEnv get appEnv => _initService.appEnv;
  Api get api => Api(appEnv: appEnv);
  ApplicationParameter get appParams =>
      appEnv.flavorValues.applicationParameter;

  adhocSaleDetails(String referenceNo, String token) {}
}
