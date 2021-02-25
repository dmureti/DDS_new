import 'package:distributor/app/locator.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:stacked/stacked.dart';

class StopMappingWidgetViewModel extends ReactiveViewModel {
  JourneyService _journeyService = locator<JourneyService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_journeyService];
}
