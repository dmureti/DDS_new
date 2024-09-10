import 'package:distributor/app/locator.dart';

import 'package:distributor/services/api_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StopService {
  ApiService apiService = locator<ApiService>();

  StopService();
}
