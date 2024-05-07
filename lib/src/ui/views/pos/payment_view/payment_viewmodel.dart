import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/models/product_service.dart';
import 'package:distributor/services/adhoc_cart_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class PaymentViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _productService = locator<ProductService>();
  final _dialogService = locator<DialogService>();
  AdhocCartService _adhocCartService = locator<AdhocCartService>();
  num _total = 0;

  calculateTotal() {
    // num total = 0;
    // items.forEach((element) {
    //   total += element['itemRate'] ?? 0 * element['quantity'];
    // });
    // return total;
    num total = 0;
    for (int x = 0; x < items.length; x++) {
      var sku = items[x];
      if (sku is Map) {
        total += sku['itemRate'] ?? sku['itemPrice'] * sku['quantity'];
      } else {
        total += sku.itemRate ?? sku.itemPrice * sku.quantity;
      }
    }
    return total;
  }

  get total {
    return _adhocCartService.calculateTotal();
  }

  final List items;
  final String ref;

  List paymentOptions = ["Cash", "Credit", "Cheque", "Multipay", "Mpesa"];

  String _paymentMode;
  String _phoneNumber;
  double _cashValue;

  String _drawerName;
  String _chequeNumber;

  PaymentViewModel(this.items, {String ref, double total})
      : ref = ref ?? "",
        _total = total ?? 0;

  String get paymentMode => _paymentMode;
  String get phoneNumber => _phoneNumber ?? "";
  double get cashValue => _cashValue ?? 0;

  String get drawerName => _drawerName ?? "";
  String get chequeNumber => _chequeNumber ?? "";

  double get difference => calculateTotal() - cashValue;

  setPaymentMode(var val) {
    _paymentMode = val;
    _adhocCartService.setPaymentMode(val);
    notifyListeners();
  }

  setPhoneNumber(String val) {
    _phoneNumber = val;
    _adhocCartService.setPhoneNumber(val);
    notifyListeners();
  }

  setCashAmount(String val) {
    _cashValue = double.parse(val);
    notifyListeners();
  }

  setDrawerName(String val) {
    _drawerName = val;
    notifyListeners();
  }

  setChequeNumber(String val) {
    _chequeNumber = val;
    notifyListeners();
  }

  commit() async {
    setBusy(true);
    final Map<String, dynamic> payment = {
      "phone": "${phoneNumber}",
      "drawerName": drawerName,
      "chequeNumber": chequeNumber,
      "cheque_amount": "",
      "maturityDate": "",
      "phone": phoneNumber,
      "amount": total,
      "mpesa_amount": total - cashValue,
      "externalAccountId": "string",
      "externalTxnID": "string",
      "externalTxnNarrative": "string",
      "payerAccount": "string",
      "payerName": "string",
      "paymentMode": paymentMode,
      "userTxnNarrative": "string"
    };
    Map<String, dynamic> data = {
      "amount": calculateTotal(),
      "payment": payment,
      "phoneNumber": phoneNumber
    };
    //Check if the ref is empty
    if (ref.isNotEmpty) {
      data.addAll({"dnId": ref});
      //Use the dn processing api
      var result = await _productService.fulfillDeliveryNotePayment(data);
      // var result = await _productService.postSale(data,
      //     modeOfPayment: _adhocCartService.paymentMode);
      if (result is CustomException) {
        await _dialogService.showDialog(
            title: 'Place Order Failed', description: result.description ?? "");
      } else {
        //Refresh the DN details
        _navigationService.back(result: true);
      }
    } else {
      ///
      ///@todo Add keys for
      /// customerId, customerName, dueDate,total,type,deliveryLocation,remarks, sellingPriceList
      var result = await _adhocCartService.createPayment();
      if (result is bool) {
        await _dialogService.showDialog(
            title: 'Success', description: 'The sale was posted successfully.');
        if (result is bool) {
          _adhocCartService.resetTotal();
        }
        _navigationService.pushNamedAndRemoveUntil(
          Routes.homeView,
          arguments: HomeViewArguments(index: 2),
        );
      } else if (result is CustomException) {
        await _dialogService.showDialog(
            title: 'Error', description: result.description);
      }
      // await _productService.postSale(data, modeOfPayment: paymentMode);
    }
    setBusy(false);
  }
}
