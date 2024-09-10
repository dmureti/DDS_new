import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tripletriocore/tripletriocore.dart';

@lazySingleton
class PermissionService {
  static final List<Permission> _requiredPerms = [Permission.location];

  PermissionManager _permissionManager = PermissionManager(_requiredPerms);

  init() async {
    var result = await _permissionManager.init();
    return result;
  }
}
