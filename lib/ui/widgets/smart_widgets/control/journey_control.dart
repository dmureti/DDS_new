import 'package:distributor/ui/widgets/smart_widgets/control/journey_control_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class JourneyControlIcon extends StatelessWidget {
  final DeliveryJourney deliveryJourney;
  const JourneyControlIcon({@required this.deliveryJourney, Key key})
      : assert(deliveryJourney != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneyControlIconViewModel>.reactive(
        builder: (context, model, child) => model.isBusy
            ? CircularProgressIndicator()
            : IconButton(
                icon: Icon(
                  model.isActive ? Icons.stop : Icons.play_arrow,
                  color: model.enableControls ? Colors.green : Colors.grey,
                ),
                onPressed: () => model.onTap(),
              ),
        viewModelBuilder: () =>
            JourneyControlIconViewModel(deliveryJourney: deliveryJourney));
  }
}
