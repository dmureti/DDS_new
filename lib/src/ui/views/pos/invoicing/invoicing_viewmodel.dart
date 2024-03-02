import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:distributor/src/ui/views/pos/sales_returns/sales_returns_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum InvoiceType { pending, failed, finalized }

class InvoicingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _stockControllerService = locator<StockControllerService>();

  pushToSAP(invoice) async {
    print("pushed to SAP");
  }

  navigateToPrint(invoice) async {
    print("pushed to SAP");
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
}
