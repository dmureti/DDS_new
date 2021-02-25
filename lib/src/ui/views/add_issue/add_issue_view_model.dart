import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AddIssueViewModel extends BaseViewModel {
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  UserService _userService = locator<UserService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
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
    var result = await _apiService.api
        .createIssue(issue.toJson(), _userService.user.token);
    setBusy(false);
    if (result is bool) {
      _snackbarService.showSnackbar(
          message: 'The issue was added successfully.');
      _navigationService.popRepeated(1);
    } else if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    }
  }
}
