import 'package:distributor/app/locator.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AddIssueViewModel extends ReactiveViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  SnackbarService _snackbarService = locator<SnackbarService>();
  CustomerService _customerService = locator<CustomerService>();
  final Customer customer;

  AddIssueViewModel(this.customer);

  String _description = "";
  String get description => _description;
  updateDesc(String val) {
    _description = val;
    notifyListeners();
  }

  String _subject = "";
  String get subject => _subject ?? "";
  updateSubject(String val) {
    _subject = val;
    notifyListeners();
  }

  String _issueType;
  String get issueType => _issueType;
  setIssueType(String val) {
    _issueType = val;
    notifyListeners();
  }

  List<String> get issues => ['Feedback', 'Request', 'Problem'];

  addIssue() async {
    Issue issue = Issue(
        customerId: customer.id,
        description: description,
        dateReported: DateTime.now().toUtc().toIso8601String(),
        issueType: "Request",
        subject: subject);
    setBusy(true);
    var result = await _customerService.addCustomerIssue(issue, customer.id);
    setBusy(false);
    if (result) {
      _snackbarService.showSnackbar(
          message: 'The issue was added successfully.');
      await _customerService.getCustomerIssues(customer.id);
      _navigationService.back(result: true);
    } else if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_customerService];
}
