import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class NotificationsTabViewModel extends BaseViewModel {
  final Customer _customer;
  UserService _userService = locator<UserService>();
  ApiService _apiService = locator<ApiService>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  NotificationsTabViewModel({@required Customer customer})
      : _customer = customer,
        assert(customer != null);

  Customer get customer => _customer;

  List<Issue> _issueList;
  List<Issue> get issueList => _issueList;

  getIssues() async {
    setBusy(true);
    var result = await _apiService.api
        .getCustomersIssuesByCustomer(customer.id, _userService.user.token);
    setBusy(false);
    if (result is List<Issue>) {
      _issueList = result;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
          title: "Error fetching Issues", description: "");
    }
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

  addIssue() async {
    Issue issue = Issue(
        customerId: customer.id,
        description: description,
        dateReported: DateTime.now().toUtc().toIso8601String(),
        issueType: "Request",
        subject: subject);
    setBusy(true);
    var result = await _apiService.api
        .createIssue(issue.toJson(), _userService.user.token);
    setBusy(false);
    if (result is bool) {
      getIssues();
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
}
