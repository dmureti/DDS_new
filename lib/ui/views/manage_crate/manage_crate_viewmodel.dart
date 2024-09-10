import 'package:distributor/app/crate_lib/crate_lib_models.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ManageCrateViewModel extends BaseViewModel {
  List _customerList;

  List<CrateMovement> _crateMovement = <CrateMovement>[];
  List<CrateMovement> get crateMovement => _crateMovement;

  List<String> crateTypes = ['Yellow', 'Orange'];

  toggleElement(String crateColor) {
    if (crateMovement.isEmpty) {
      _crateMovement.add(CrateMovement(crateColor: crateColor));
      notifyListeners();
      return;
    } else {
      //Loop through the array
      crateMovement.firstWhere(
          (element) => element.color.toLowerCase() == crateColor.toLowerCase(),
          orElse: () {
        return CrateMovement(crateColor: crateColor);
      });
    }
  }

  checkIfElementExists(String crateColor) {
    for (var crateCol in crateMovement) {
      if (crateCol.color.toLowerCase().contains(crateColor.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  removeElement() {}
  changeElementStatus() {}

  String _crateTxnType;
  Customer _customer;
  String _crateType;

  String get crateTxnType => _crateTxnType;
  Customer get customer => _customer;
  String get crateType => _crateType;

  List<String> _crates = <String>[];
  List<String> get crates => _crates;
  setCrates(String c) {
    if (_crates.contains(c.toLowerCase())) {
      _crates.remove(c);
    } else {
      _crates.add(c);
    }
    notifyListeners();
  }

  set crateTxnType(var c) {
    _crateTxnType = c;
    notifyListeners();
  }

  set crateType(var c) {
    _crateType = c;
    notifyListeners();
  }

  set customer(Customer c) => _customer = c;

  ManageCrateViewModel(
      {String crateTxnType, Customer customer, String crateType})
      : _crateType = crateType,
        _customer = customer,
        _crateTxnType = crateTxnType;
}
