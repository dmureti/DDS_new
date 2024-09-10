import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ContactsTabViewViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  navigateToLocation(Customer customer) async {
    await _navigationService.navigateTo(
      Routes.customerLocation,
      arguments: CustomerLocationArguments(customer: customer),
    );
  }
}
