import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StopsListWidgetViewModel extends BaseViewModel {
  ApiService _apiService = locator<ApiService>();
  UserService _userService = locator<UserService>();
  DialogService _dialogService = locator<DialogService>();
  CustomerService _customerService = locator<CustomerService>();

  DeliveryJourney _deliveryJourney;
  DeliveryJourney get deliveryJourney => _deliveryJourney;

  final String _journeyId;

  StopsListWidgetViewModel({String journeyId})
      : _journeyId = journeyId,
        assert(journeyId != null);

  getJourneyDetails() async {
    var result = await _apiService.api.getJourneyDetails(
        token: _userService.user.token, journeyId: _journeyId);
    if (result is DeliveryJourney) {
      _deliveryJourney = result;
      notifyListeners();
    } else if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    }
  }

  getAddress() {
    try {} catch (e) {}
  }

  Future fetchCustomerDetails(String customerId) async {
    var result = await _customerService.getCustomerDetailById(customerId);
    if (result is Customer) {
      return result;
    } else {
      await _dialogService.showDialog(
          title: 'Could not fetch $customerId', description: result.toString());
    }
  }
}
