import 'package:injectable/injectable.dart';

// Manages the services that are required
// This is a wrapper service
@lazySingleton
class BootstrapService {
  List _persistentServices;
  List _requiredServices;

  List get persistentServices => _persistentServices;
  List get requiredServices => _requiredServices;

  init() async {}
}
