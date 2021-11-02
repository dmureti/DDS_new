import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/services/adhoc_cart_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';

class AdhocDetailViewModel extends BaseViewModel {
  final String referenceNo;
  final _adhocService = locator<AdhocCartService>();
  final _userService = locator<UserService>();

  String get token => _userService.user.token;

  AdhocDetailViewModel(this.referenceNo);

  bool _fetched = false;
  bool get fetched => _fetched;

  AdhocDetail _adhocDetail;
  AdhocDetail get adhocDetail => _adhocDetail;

  getAdhocDetail() async {
    _adhocDetail = await _adhocService.fetchAdhocDetail(referenceNo, token);
    _fetched = true;
    notifyListeners();
  }
}
