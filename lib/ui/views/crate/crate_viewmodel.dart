import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/enums.dart';
import 'package:distributor/core/models/crate.dart';
import 'package:distributor/services/crate_,management_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CrateViewModel extends BaseViewModel {
  final _crateService = locator<CrateManagementService>();
  final _navigationService = locator<NavigationService>();

  List<Crate> crates = <Crate>[
    Crate(name: 'Yellow', count: 10),
    Crate(name: 'Green', count: 20),
  ];

  init() async {
    await _getCrates();
  }

  _getCrates() async {
    setBusy(true);
    _crateService.crates;
    setBusy(false);
    notifyListeners();
  }

  void navigateToManageCrateView(
      {String crateTxnType, String crateType}) async {
    await _navigationService.navigateTo(Routes.manageCrateView,
        arguments: ManageCrateViewArguments(
            crateType: crateType, crateTxnType: crateTxnType));
  }
}
