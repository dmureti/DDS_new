// Will maintain info about a user
import 'package:distributor/services/api_service.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/app/locator.dart';

class UserService {
  ApiService _apiService = locator<ApiService>();

  User _user;
  User get user => _user;

  updateUser(User user) {
    _user = user;
  }

  resetPassword() async {
    var result =
        await _apiService.api.resetAppUserPassword(user.token, user.id);
    return result;
  }

  changePassword(String current, String newPass) async {
    Map<String, dynamic> data = {"current": current, "new": newPass};
    var result = await _apiService.api.changeAppUserPwd(user.token, data);
    return result;
  }
}
