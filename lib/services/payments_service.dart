import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class PaymentsService with ReactiveServiceMixin {
  PaymentsService() {
    listenToReactiveValues([_paymentsReceived]);
  }

  RxValue<int> _paymentsReceived = RxValue<int>(initial: 0);
  int get paymentsReceived => _paymentsReceived.value;
}
