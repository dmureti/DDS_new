import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/core/models/invoice.dart';
import 'package:distributor/services/adhoc_cart_service.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:distributor/src/ui/views/pos/sales_returns/sales_returns_view.dart';
import 'package:distributor/src/ui/views/print_view/print_view.dart';
import 'package:flutter/src/material/date.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum InvoiceType { pending, failed, finalized }

class InvoicingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _stockControllerService = locator<StockControllerService>();
  final _userService = locator<UserService>();
  final _adhocService = locator<AdhocCartService>();

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;

  pushToSAP(invoice) async {
    print("pushed to SAP");
  }

  getAdhocDetail(String referenceNo, String baseType) async {
    setBusy(true);
    return await _adhocService.fetchAdhocDetail(
        referenceNo, _userService.user.token, baseType);
    setBusy(false);
  }

  navigateToPrint(invoice, String referenceNo, String baseType) async {
    AdhocDetail adhocDetail = await getAdhocDetail(referenceNo, baseType);
    _navigationService.navigateToView(PrintView(
      invoice: Invoice.fromMap(invoice),
      deliveryNote: adhocDetail,
      title: "E-Invoice",
      customerTIN: "",
      items: invoice['items'],
      orderId: referenceNo,
      user: _userService.user,
    ));
  }

  init() async {
    await fetchPendingInvoices();
    await fetchFailedInvoices();
    await fetchFinalizedInvoices();
  }

  List _pendingInvoices = [];
  List _finalizedInvoices = [];
  List _failedInvoices = [];

  List get pendingInvoices => _pendingInvoices;
  List get finalizedInvoices => _finalizedInvoices;
  List get failedInvoices => _failedInvoices;

  fetchPendingInvoices() async {
    setBusy(true);
    _pendingInvoices = await _stockControllerService.getInvoices("pending");
    setBusy(false);
    notifyListeners();
  }

  fetchFinalizedInvoices() async {
    setBusy(true);
    _finalizedInvoices = await _stockControllerService.getInvoices("finalized");
    setBusy(false);
    notifyListeners();
  }

  fetchFailedInvoices() async {
    setBusy(true);
    _failedInvoices = await _stockControllerService.getInvoices("failed");
    setBusy(false);
    notifyListeners();
  }

  void submitReturns(invoice) async {
    await _navigationService.navigateToView(SalesReturnsView(
      invoice: invoice,
    ));
    await fetchFinalizedInvoices();
  }

  navigateToView(invoice) async {
    var result = await _navigationService.navigateTo(
      Routes.adhocDetailView,
      arguments: AdhocDetailViewArguments(
          referenceNo: invoice['deliveryNoteId'],
          customerId: invoice['customerCode'],
          baseType: "contract"),
    );
  }

  void updateFinalizedOrderRange(DateTimeRange result) async {
    _startDate = result.start;
    _endDate = result.end;
    setBusy(true);
    Future.delayed(Duration(seconds: 2), () => setBusy(false));
    _finalizedInvoices = await _stockControllerService.getInvoices("finalized",
        startDate: startDate, endDate: endDate);
    notifyListeners();
  }

  void refresh() async {
    DateTime _startDate = DateTime.now();
    DateTime _endDate = DateTime.now();
    setBusy(true);
    _finalizedInvoices = await _stockControllerService.getInvoices("finalized",
        startDate: startDate, endDate: endDate);
        setBusy(false);
    notifyListeners();
  }
}
