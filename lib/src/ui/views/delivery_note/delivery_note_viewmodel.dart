import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/enums.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class DeliveryNoteViewModel extends BaseViewModel {
  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  NavigationService _navigationService = locator<NavigationService>();
  JourneyService _journeyService = locator<JourneyService>();
  UserService _userService = locator<UserService>();
  User get _user => _userService.user;
  DeliveryJourney _deliveryJourney;
  DeliveryStop _deliveryStop;
  ApiService _apiService = locator<ApiService>();

  DeliveryJourney get deliveryJourney => _deliveryJourney;
  DeliveryStop get deliveryStop => _deliveryStop;
  final Customer customer;
  LocationService _locationService = locator<LocationService>();

  DeliveryNote _deliveryNote;
  DeliveryNote get deliveryNote => _deliveryNote;

  getDeliveryNote() async {
    var result = await _apiService.api.getDeliveryNoteDetails(
        deliveryNoteId: deliveryStop.deliveryNoteId, token: _user.token);
    if (result is DeliveryNote) {
      _deliveryNote = result;
      notifyListeners();
    }
  }

  DeliveryNoteViewModel(
      DeliveryJourney deliveryJourney, DeliveryStop deliveryStop, this.customer)
      : _deliveryStop = deliveryStop,
        _deliveryJourney = deliveryJourney;

  String _deliveryLocation;
  String get deliveryLocation => _deliveryLocation;

  getCurrentLocation() async {
    var result = await _locationService.getLocation();
    if (result != null) {
      _deliveryLocation = "${result.latitude},${result.longitude}";
      notifyListeners();
    }
  }

  init() async {
    await getCurrentLocation();
    await getDeliveryNote();
  }

  handleOrderAction(String action) async {
    switch (action) {
      case 'full_delivery':
        if (deliveryStop != null) {}
        DialogResponse response = await _dialogService.showConfirmationDialog(
            description:
                'You are about to close the Sales Order ${deliveryStop.orderId} for ${deliveryStop.customerId}.',
            title: 'COMPLETE ORDER',
            confirmationTitle: 'CONFIRM',
            cancelTitle: 'CANCEL');
        if (response.confirmed) {
          setBusy(true);
          var result = await _journeyService.makeFullSODelivery(
              deliveryStop.orderId, deliveryStop.stopId, deliveryLocation);
          setBusy(false);
          if (result is CustomException) {
            await _dialogService.showDialog(
                title: result.title, description: result.description);
          } else {
            await getDeliveryNote();
            //@TODO change snackbar
            _snackbarService.showSnackbar(
                message: 'The delivery was closed successfully');
          }
        }
        break;
      case 'partial_delivery':
        var result = await _navigationService.navigateTo(
            Routes.partialDeliveryView,
            arguments: PartialDeliveryViewArguments(
                deliveryJourney: deliveryJourney,
                deliveryStop: deliveryStop,
                deliveryNote: deliveryNote));
        if (result is CustomException) {
          await _dialogService.showDialog(
              title: result.title, description: result.description);
        } else {
          //Check if delivery was completed
          if (result is bool) {
            if (result) {
              _snackbarService.showSnackbar(
                  message: 'The partial delivery was closed successfully');
              await getDeliveryNote();
            }
          }
        }
        break;
      case 'add_payment':
        var result = await _navigationService.navigateTo(Routes.addPaymentView,
            arguments: AddPaymentViewArguments(customer: customer));
        if (result) {
          _snackbarService.showSnackbar(
              message: 'The payment was added successfully.');
        }
        break;
      case 'not_possible':
        await _dialogService.showDialog(
            title: 'Operation not possible',
            description: 'You cannot perform this action.');
        break;
      case 'drop_crates': //Drop the crates at a customer
        _navigationService.navigateTo(Routes.crateMovementView,
            arguments: CrateMovementViewArguments(
                crateTxnType: CrateTxnType.Drop,
                customer: customer,
                deliveryStop: deliveryStop));
        break;
      case 'receive_crates': // Receive crates from a customer
        _navigationService.navigateTo(
          Routes.crateMovementView,
          arguments: CrateMovementViewArguments(
              crateTxnType: CrateTxnType.Pickup,
              customer: customer,
              deliveryStop: deliveryStop),
        );
        break;
      case 'crates_return':
        _navigationService.navigateTo(
          Routes.crateMovementView,
          arguments: CrateMovementViewArguments(
              crateTxnType: CrateTxnType.Return,
              customer: customer,
              deliveryStop: deliveryStop),
        );
        break;
    }
  }
}
