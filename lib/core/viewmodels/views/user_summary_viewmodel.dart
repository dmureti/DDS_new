import 'package:flutter/cupertino.dart';
import 'package:tripletriocore/tripletriocore.dart';

class UserSummaryViewmodel extends BaseModel {
  final Api _api;
  final User _user;
  User get user => _user;

  UserSummary _userSummary;
  UserSummary get userSummary => _userSummary;

  UserSummaryViewmodel({@required Api api, @required User user})
      : _api = api,
        _user = user,
        assert(api != null, user != null);

  init() async {
    await getUserSummary();
  }

  Future<void> getUserSummary() async {
    setBusy(true);
    APIResponseObject apiResponseObject =
        await _api.getUserSummary(user.token, userId: user.email);
    if (apiResponseObject.status) {
      _userSummary = apiResponseObject.payload;
    } else {
      _userSummary = apiResponseObject.payload;
    }
    setBusy(false);
  }
}
