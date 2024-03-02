import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/product_service.dart';
import 'package:stacked/stacked.dart';

class QuotationDetailViewModel extends BaseViewModel {
  final _productService = locator<ProductService>();
  final String quotationId;

  var _quotation;
  get quotation => _quotation;

  List _items;
  var _customer;
  var _warehouse;

  List get items => _items;
  get customer => _customer;
  get warehouse => _warehouse;

  fetchQuotationDetail() async {
    setBusy(true);
    _quotation = await _productService.getQuotationDetail(quotationId);
    _items = _quotation['items'];
    _customer = _quotation['customer'];
    _warehouse = _quotation['warehouse'];
    setBusy(false);
  }

  shareQuotation() async {}

  QuotationDetailViewModel(this.quotationId);

  init() async {
    await fetchQuotationDetail();
  }

  generateInvoice() async {
    setBusy(true);
    Map<String, dynamic> data = {
      "customer": customer['customerCode'],
      "sellingPriceList": "4SumPriceList",
      "company": "4SUM",
      "items": items
          .map((e) => {
                "item": {
                  "id": "${e['id']}",
                  "itemCode": "${e['itemCode']}",
                  "itemName": "${e['itemName']}",
                  "itemPrice": e['itemPrice'],
                  "quantity": e['quantity'],
                },
                "quantity": e['quantity'],
              })
          .toList(),
      "quotationId": quotationId,
      "dueDate": DateTime.parse(quotation['dueDate']).toUtc().toIso8601String(),
      "warehouse": "",
      "remarks": "Order Created from Quotation",
    };
    var result = await _productService.generateInvoiceFromQuotation(data);
    setBusy(false);
  }
}
