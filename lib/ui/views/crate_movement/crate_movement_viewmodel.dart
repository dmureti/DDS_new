import 'package:distributor/app/locator.dart';
import 'package:distributor/core/enums.dart';
import 'package:distributor/services/crate_,management_service.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CrateMovementViewModel extends BaseViewModel {
  final _crateManagementService = locator<CrateManagementService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _customerService = locator<CustomerService>();
  final _userService = locator<UserService>();

  User get user => _userService.user;

  final DeliveryStop _deliveryStop;
  final CrateTxnType _crateTxnType;
  bool _disableTextFormField;
  bool get disableTextFormField => _disableTextFormField;

  CrateMovementViewModel(this._deliveryStop, this._crateTxnType)
      : _disableTextFormField = _crateTxnType != CrateTxnType.Return,
        _customerId = _deliveryStop?.customerId,
        _journeyId = _deliveryStop?.journeyId,
        _dnId = _deliveryStop?.deliveryNoteId,
        _isValid = _crateTxnType == CrateTxnType.Return;

  toggleDisableTextFormField() {
    _disableTextFormField = !disableTextFormField;
    notifyListeners();
  }

  List<String> editReasons = ["Stolen", "Missing", "Other"];

  String _reason;
  String get reason => _reason ?? editReasons.last;
  setReason(String reason) {
    _reason = reason;
    notifyListeners();
  }

  List<Product> _crateList = <Product>[];
  List<Product> get crateList => _crateList;
  String _customerId;
  String _journeyId;
  String _dnId;
  bool _isValid;

  String get journeyId => _journeyId;
  String get dnId => _dnId;
  DeliveryStop get deliveryStop => _deliveryStop;
  CrateTxnType get crateTxnType => _crateTxnType;
  bool get isReturn => disableTextFormField;
  String get customerId => _customerId;

  bool get isValid => _isValid;

  listCrates() async {
    setBusy(true);
    List<Item> result = await _crateManagementService.listCrates();
    _crateList = result
        .map((e) => Product(
            itemPrice: e.itemPrice,
            id: e.id,
            itemCode: e.itemCode,
            itemName: e.itemName,
            quantity: 0))
        .toList();
    setBusy(false);
    notifyListeners();
  }

  init() async {
    switch (crateTxnType) {
      case CrateTxnType.Return:
        await _getCrates();
        break;
      case CrateTxnType.Pickup:
        await listCrates();
        break;
      case CrateTxnType.Drop:
        await listCrates();
        break;
    }
    if (_deliveryStop == null && crateTxnType != CrateTxnType.Return) {
      await _fetchCustomers();
    }
  }

  _getCrates() async {
    setBusy(true);
    _crateList = await _crateManagementService.fetchCrates();
    setBusy(false);
    notifyListeners();
  }

  updateItemSet(String val, Product crate) {
    if (val.isNotEmpty) {
      Item item = Item(
          itemName: crate.itemName,
          itemCode: crate.itemCode,
          itemPrice: crate.itemPrice,
          id: crate.itemCode);
      // Check if the list is empty
      if (itemSet.isNotEmpty) {
        itemSet
            .removeWhere((item, quantity) => item.itemCode == crate.itemCode);

        // If its not check if it contains this item
        _itemSet.addAll({item: int.parse(val)});
        // If it does update the item

        // If the value is 0 remove the item
      } else {
        // Add the item to the list
        _itemSet.addAll({item: int.parse(val)});
      }
    }
    print(itemSet.length);
  }

  Map<Item, int> _itemSet = Map<Item, int>();
  Map<Item, int> get itemSet => _itemSet;

  int _received = 0;
  int _dropped = 0;

  int get received => _received;
  int get dropped => _dropped;

  bool _enableCommit = false;
  bool get enableCommit => _enableCommit;

  commitReturnCrates() async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
        title: 'Return Crates Confirmation',
        cancelTitle: 'NO',
        confirmationTitle: 'YES, I AM SURE',
        description:
            'Are you sure you want to return the crates to the warehouse? ');
    if (dialogResponse.confirmed) {
      List<SalesOrderItem> actualReturned = <SalesOrderItem>[];
      //Check if the user has edited
      if (itemSet.isNotEmpty) {
        itemSet.forEach((key, value) {
          SalesOrderItem s = SalesOrderItem(
              item: Product(
                quantity: value,
                itemName: key.itemName,
                itemPrice: key.itemPrice,
                id: key.id,
                itemCode: key.itemCode,
              ),
              quantity: crateTxnType == CrateTxnType.Drop ? value * -1 : value);
          //Update the sums
          // computeTotal(value);
          actualReturned.add(s);
        });
      } else {
        crateList.forEach((product) {
          SalesOrderItem s =
              SalesOrderItem(item: product, quantity: product.quantity);
          actualReturned.add(s);
        });
      }
      var result = await _crateManagementService.cratesReturn(
          expectedCrates: _crateList,
          reason: reason,
          actualReturnedCrates: actualReturned);
      if (result) {
        await _dialogService.showDialog(
            title: 'Crate Return Success',
            description:
                'You have successfully returned the crates to the warehouse.');
        _navigationService.back(result: true);
      }
    }
  }

  void commitChanges() async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
        title: 'Collect / Drop crate confirmation',
        cancelTitle: 'NO',
        confirmationTitle: 'YES, I AM SURE',
        description:
            'Are you sure you want to drop / collect the number of items you have listed ? ');
    if (dialogResponse.confirmed) {
      List<SalesOrderItem> salesOrderItems = <SalesOrderItem>[];
      itemSet.forEach((key, value) {
        SalesOrderItem s = SalesOrderItem(
            item: Product(
              quantity: value,
              itemName: key.itemName,
              itemPrice: key.itemPrice,
              id: key.id,
              itemCode: key.itemCode,
            ),
            quantity: crateTxnType == CrateTxnType.Drop ? value * -1 : value);
        //Update the sums
        computeTotal(value);
        salesOrderItems.add(s);
      });
      var result = await _crateManagementService.collectDropCrates(
          customer: customerId,
          dnId: dnId,
          received: received,
          dropped: dropped,
          items: salesOrderItems,
          journeyId: journeyId);
      if (result) {
        await _dialogService.showDialog(
            title: 'Transaction Success',
            description: 'The action was performed successfully');
        _navigationService.back(result: true);
      }
    }
  }

  computeTotal(int val) {
    switch (crateTxnType) {
      case CrateTxnType.Return:
        break;
      case CrateTxnType.Drop:
        _dropped += val;
        break;
      case CrateTxnType.Pickup:
        _received += val;
        break;
    }
  }

  setCustomer(Customer customer) {
    _customerId = customer.name;
    _isValid = true;
    notifyListeners();
  }

  List<Customer> _customerList;
  List<Customer> get customerList => _customerList;

  _fetchCustomers() async {
    setBusy(true);
    _customerList = await _customerService.customers;
    setBusy(false);
  }
}
