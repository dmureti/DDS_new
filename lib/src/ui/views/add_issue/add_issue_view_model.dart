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
  User get user => _customerService.user;

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
    Map<String, dynamic> data = {
      "date_reported": DateTime.now().toUtc().toIso8601String(),
      "created_by": user.full_name,
      "created_by_user_id": user.id,
      "subject": subject,
      "description": description,
      "issue_type": issueType,
      "customer_code": customer.customerCode,
      "customer_id": customer.id,
      "customer_name": customer.name,
      "branch": customer.branch
    };
    // Issue issue = Issue(
    //     customerId: customer.id,
    //     description: description,
    //     dateReported: DateTime.now().toUtc().toIso8601String(),
    //     issueType: "Request",
    //     subject: subject);
    setBusy(true);
    var result =
        await _customerService.addCustomerIssue(data, customer.customerCode);
    setBusy(false);
    if (result) {
      _snackbarService.showSnackbar(
          title: 'Success', message: 'The issue was added successfully.');
      await _customerService.getCustomerIssues(customer.customerCode);
      _navigationService.back(result: true);
    } else if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_customerService];
}
