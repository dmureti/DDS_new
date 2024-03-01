import 'package:distributor/app/locator.dart';
import 'package:distributor/core/models/product_service.dart';
import 'package:stacked/stacked.dart';

class QuotationDetailViewModel extends BaseViewModel {
  final _productService = locator<ProductService>();

  final quotation;

  fetchQuotationDetail() async {}
  shareQuotation() async {}

  QuotationDetailViewModel(this.quotation);
}
