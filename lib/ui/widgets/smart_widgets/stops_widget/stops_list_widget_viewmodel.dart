import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StopsListWidgetViewModel extends FutureViewModel<DeliveryJourney> {
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

  Future<DeliveryJourney> getJourneyDetails() async {
    DeliveryJourney deliveryJourney = await _apiService.api.getJourneyDetails(
        token: _userService.user.token, journeyId: _journeyId);
    return deliveryJourney;
  }

  @override
  Future<DeliveryJourney> futureToRun() async {
    var result = await _apiService.api.getJourneyDetails(
        token: _userService.user.token, journeyId: _journeyId);
    return result;
  }

  getAddress() {
    try {} catch (e) {}
  }

  @override
  void onError(error) {
    _dialogService.showDialog(
        title: 'Error fetching stops', description: error);
    super.onError(error);
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
