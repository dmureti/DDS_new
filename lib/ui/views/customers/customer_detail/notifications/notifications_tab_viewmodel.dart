import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class NotificationsTabViewModel extends ReactiveViewModel {
  final Customer _customer;
  UserService _userService = locator<UserService>();
  ApiService _apiService = locator<ApiService>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  CustomerService _customerService = locator<CustomerService>();

  NotificationsTabViewModel({@required Customer customer})
      : _customer = customer,
        assert(customer != null);

  Customer get customer => _customer;

  List<Issue> get issueList => _customerService.issueList;

  getIssues() async {
    setBusy(true);
    await _customerService.getCustomerIssues(customer.customerCode);
    setBusy(false);
    notifyListeners();
  }

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

  showDetailedIssueDialog(Issue issue) async {
    await _dialogService.showDialog(
        title: issue.subject,
        description:
            issue.description ?? "This issue does not have a description");
  }

  addIssue() async {
    Issue issue = Issue(
        customerId: customer.id,
        description: description,
        dateReported: DateTime.now().toUtc().toIso8601String(),
        issueType: "Request",
        subject: subject);
    setBusy(true);
    var result =
        await _customerService.addCustomerIssue(issue.toJson(), customer.id);
    setBusy(false);
    if (result is bool) {
      await getIssues();
    } else if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    }
  }

  navigateToAddIssue(Customer customer) async {
    var result = await _navigationService.navigateTo(Routes.addIssueView,
        arguments: AddIssueViewArguments(customer: customer));
    if (result is bool) {
      await getIssues();
      _snackbarService.showSnackbar(
          message: 'The issue was added successfully.');
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_customerService];
}
