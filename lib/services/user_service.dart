// Will maintain info about a user
import 'package:auto_route/auto_route.dart';
import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

class UserService {
  ApiService _apiService = locator<ApiService>();

  User _user;
  User get user => _user;

  updateUser(User user) {
    _user = user;
  }

  ///{
  //   "identityType": "string",
  //   "identityValue": "string",
  //   "resetCode": "string",
  //   "password": "string"
  // }
  completeResetMyPassword(
      {@required String identityValue,
      @required resetCode,
      @required password}) async {
    String identityType = checkIdentificationType(identityValue);
    Map<String, dynamic> data = {
      "identityType": identityType,
      "identityValue": identityValue,
      "resetCode": resetCode,
      "password": password
    };
    var result = await _apiService.api.completeResetMyPassword(data);
    return result;
  }

  clearAPPCache() async {
    await _apiService.api.clearAPICache();
  }

  resetPassword({
    @required String identityValue,
  }) async {
    String identityType;
    if (identityValue.contains('@')) {
      identityType = "email";
    } else {
      identityType = "mobile";
    }
    Map<String, dynamic> data = {
      "identityValue": identityValue,
      "identityType": identityType
    };
    var result = await _apiService.api.initResetMyPassword(data: data);
    return result;
  }

  changePassword(String current, String newPass) async {
    Map<String, dynamic> data = {"current": current, "new": newPass};
    var result = await _apiService.api.changeAppUserPwd(user.token, data);
    return result;
  }

  String checkIdentificationType(var value) {
    if (value.toString().contains('@')) {
      return "email";
    } else {
      return "mobile";
    }
  }

  getUserSummary() async {
    return await _apiService.api.getUserSummary(user.token, user: user);
  }
}
