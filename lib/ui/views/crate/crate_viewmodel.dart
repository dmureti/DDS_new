import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/enums.dart';
import 'package:distributor/core/models/crate.dart';
import 'package:distributor/services/crate_,management_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CrateViewModel extends BaseViewModel {
  final _crateService = locator<CrateManagementService>();
  final _navigationService = locator<NavigationService>();

  List<Product> _crates;
  List<Product> get crates => _crates;

  init() async {
    await _getCrates();
  }

  _getCrates() async {
    setBusy(true);
    _crates = await _crateService.fetchCrates();
    setBusy(false);
    notifyListeners();
  }

  void navigateToManageCrateView(
      {String crateTxnType, String crateType}) async {
    await _navigationService.navigateTo(Routes.manageCrateView,
        arguments: ManageCrateViewArguments(
            crateType: crateType, crateTxnType: crateTxnType));
  }

  void testReturn() {
    List<SalesOrderItem> items = [
      SalesOrderItem(
          item: Product(
              id: 'OC003',
              itemCode: 'OC003',
              itemName: 'Crates',
              itemPrice: 0,
              quantity: 8))
    ];
    _crateService.collectDropCrates(
        customer: "Naivas Group",
        dnId: "DN-22-00026",
        received: 10,
        dropped: 2,
        items: items);
  }
}
