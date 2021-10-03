import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

/// The [ActivityService] shall keep a log of all mutable activities within the session
///
@lazySingleton
class ActivityService with ReactiveServiceMixin {
  RxValue<int> _noOfUpdates = RxValue<int>(initial: 0);
  int get noOfUpdates => _noOfUpdates.value;

  updateHasUpdate(bool val) {
    if (val == false) {
      _noOfUpdates.value = 0;
    }
    _hasUpdate.value = val;
  }

  ActivityService() {
    listenToReactiveValues([_sessionActivityList, _hasUpdate, _noOfUpdates]);
  }

  // List of activities that the user has been involved in
  RxValue<List<Activity>> _sessionActivityList =
      RxValue<List<Activity>>(initial: <Activity>[]);
  List<Activity> get sessionActivityList => _sessionActivityList.value;

  RxValue<bool> _hasUpdate = RxValue<bool>(initial: false);
  bool get hasUpdate => _hasUpdate.value;

  addActivity(Activity activity) {
    _sessionActivityList.value.add(activity);
    _noOfUpdates.value++;
    updateHasUpdate(true);
  }
}
