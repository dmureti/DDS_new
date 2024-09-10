import 'package:distributor/app/locator.dart';
import 'package:distributor/services/activity_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class NotificationViewModel extends ReactiveViewModel {
  ActivityService _activityService = locator<ActivityService>();

  NotificationViewModel() {
    _activityService.updateHasUpdate(false);
  }

  List<Activity> get appActivity => _activityService.sessionActivityList;

  int get appActivityLength => appActivity.length;

  bool get hasUpdate => _activityService.hasUpdate;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_activityService];
}
