import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class TerritoryViewModel extends BaseViewModel {
  final userService = locator<UserService>();
  final navigationService = locator<NavigationService>();

  List<Fence> get fenceList => userService.user.fences ?? <Fence>[];

  init() async {}

  navigateToTerritoryDetail(Fence fence) async {
    await navigationService.navigateTo(Routes.territoryDetailView,
        arguments: TerritoryDetailViewArguments(fence: fence));
  }
}
