import 'package:injectable/injectable.dart';

import '../core/enums.dart';

@lazySingleton
class BaseService {
  ServiceType get serviceType => ServiceType.Persistent;
  bool get isRequired => true;
}
