import 'package:distributor/app/locator.dart';
import 'package:distributor/services/logistics_service.dart';

import 'package:stacked/stacked.dart';

/// Uses the [ReactiveViewModel] to react to changes in state of the journey
class StopControlViewModel extends ReactiveViewModel {
  LogisticsService _logisticsService = locator<LogisticsService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_logisticsService];
}
