import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class DeliveryNoteViewModel extends BaseViewModel {
  final DeliveryJourney deliveryJourney;
  final DeliveryStop deliveryStop;

  DeliveryNoteViewModel(this.deliveryJourney, this.deliveryStop);
}
