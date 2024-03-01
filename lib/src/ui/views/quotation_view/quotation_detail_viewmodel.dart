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
      "quotationId": quotationId,
      "customer": customer['customerCode'],
      "dueDate": DateTime.parse(quotation['dueDate']).toUtc().toIso8601String(),
      "items": items
          .map((e) => {
                "amount": "${e['itemPrice'] * e['itemPrice']}",
                "item": {
                  "id": "${e['id']}",
                  "itemCode": "${e['itemCode']}",
                  "itemName": "${e['itemName']}",
                  "itemPrice": "${e['itemPrice']}",
                  "itemType": "product",
                  "priceList": "4SumPriceList"
                },
                "quantity": e['quantity'],
                "rate": e['itemPrice'],
                "tax": "16%",
              })
          .toList()
    };
    var result = await _productService.generateInvoiceFromQuotation(data);
    setBusy(false);
  }
}
