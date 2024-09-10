import 'package:distributor/app/locator.dart';
import 'package:distributor/services/customer_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerSummaryViewModel extends BaseViewModel {
  CustomerService _customerService = locator<CustomerService>();
  DialogService _dialogService = locator<DialogService>();
  final String _customerId;

  CustomerSummaryViewModel(this._customerId);

  Customer _customer;
  Customer get customer => _customer;

  init() async {
    await fetchCustomer();
  }

  fetchCustomer() async {
    var result = await _customerService.getCustomerDetailById(_customerId);
    if (result is Customer) {
      _customer = result;
      notifyListeners();
    }
    print(result);
    return result;
  }

  callCustomer() async {
    var result = await launch("tel:${customer.telephone}");
    return result;
  }

  messageCustomer() async {
    var result = await launch("sms:${customer.telephone}");
    return result;
  }

  // @override
  // void onError(error) async {
  //   await _dialogService.showDialog(
  //       title: 'Could not fetch customer', description: error.toString());
  //   super.onError(error);
  // }

  // @override
  // Future futureToRun() async {
  //   var result = await fetchCustomer();
  //
  //   if (result is Customer) {
  //     _customer = result;
  //     return _customer;
  //   } else {
  //     onError(result);
  //   }
  // }
}
