import 'package:distributor/app/locator.dart';
import 'package:distributor/services/access_controller_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

mixin ContextualViewmodel {
  final _accessControlService = locator<AccessControlService>();
  final _navigationService = locator<NavigationService>();

  navigateToPendingTransactionsView() async {}

  navigateToVoucherDetail(String stocktransactionId) async {}

  navigateToReturnStockView() async {}

  User get user => _accessControlService.user;
  List<Authority> get _authList => _accessControlService.authList;

  String salesChannel;

  bool get showShop {
    if (user.hasSalesChannel) {
      if (user.salesChannel != null) {
        if (user.salesChannel.trim().length > 0) {
          salesChannel = user.salesChannel;
          return true;
        }
        return false;
      }
      return false;
    } else {
      return false;
    }
  }

  bool get renderPendingStockTransactionsButton {
    if (user.hasSalesChannel &&
        _accessControlService.checkIfAuthExists(
            _authList, Authority(auth: 'ITR.AUTH'))) {
      return true;
    } else {
      return false;
    }
  }

  bool get showReturnStockIconButton {
    if (user.hasSalesChannel) {
      return true;
    }
    return false;
  }
}
