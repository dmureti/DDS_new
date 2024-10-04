import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
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
  final _navigationService = locator<NavigationService>();
  User get user => _userService.user;

  DeliveryJourney _deliveryJourney;
  DeliveryJourney get deliveryJourney => _deliveryJourney;

  final String _journeyId;

  StopsListWidgetViewModel({String journeyId})
      : _journeyId = journeyId,
        assert(journeyId != null);

  // Future<void> getJourneyDetails() async {
  //   try {
  //     // Set the loading state to true (show the progress indicator)
  //     setBusy(true);

  //     // Make the API call to fetch journey details
  //     var result = await _apiService.api.getJourneyDetails(
  //         token: _userService.user.token, journeyId: _journeyId);

  //     // Handle the result
  //     if (result is DeliveryJourney) {
  //       _deliveryJourney = result;
  //       // Notify listeners to update the UI after data is fetched
  //       notifyListeners();
  //     } else if (result is CustomException) {
  //       // Show error dialog if the result is an exception
  //       await _dialogService.showDialog(
  //           title: result.title, description: result.description);
  //     }
  //   } catch (e) {
  //     // Handle any unexpected errors (e.g., network issues)
  //     await _dialogService.showDialog(
  //         title: 'Error', description: 'Failed to fetch journey details');
  //   } finally {
  //     // Always set the loading state to false (hide the progress indicator)
  //     setBusy(false);
  //   }
  // }

  getJourneyDetails() async {
    setBusy(true);
    // Simulate API call to fetch journey details
    await Future.delayed(const Duration(seconds: 1));
    var result = await _apiService.api.getJourneyDetails(
        token: _userService.user.token, journeyId: _journeyId);
    setBusy(false);
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

  Future fetchCustomerDetails(var customerId) async {
    var result = await _customerService.getCustomerDetailById(customerId);
    if (result is Customer) {
      return result;
    } else {
      await _dialogService.showDialog(
          title: 'Could not fetch $customerId', description: result.toString());
    }
  }

  init() async {
    await getJourneyDetails();
  }

  void navigateToTechnicalStop(DeliveryStop deliveryStop) async {
    // Set loading state before navigation
    setBusy(true);

    // Simulate navigation and data fetching
    await Future.delayed(const Duration(seconds: 2));

    // Set loading state to false after data is fetched
    setBusy(false);
    await _navigationService.navigateTo(Routes.stockCollectionView,
        arguments: StockCollectionViewArguments(deliveryStop: deliveryStop));
    await getJourneyDetails();
    notifyListeners();
  }
}
