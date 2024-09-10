import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/smart_widgets/control/select_control/select_control_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

/// This widget is used to control the [JourneyState] of a [DeliveryJourney]
class SelectControlWidget extends StatelessWidget {
  final DeliveryJourney deliveryJourney;
  const SelectControlWidget({Key key, this.deliveryJourney})
      : assert(deliveryJourney != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectControlWidgetViewModel>.reactive(
        builder: (context, model, child) => SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: model.isBusy
                    ? Center(
                        child: BusyWidget(),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                model.isCurrentSelection
                                    ? kStopControl
                                    : kSelectControl)),
                        onPressed: () {
                          model.toggleSelectedJourney(deliveryJourney);
                        },
                        child: model.isCurrentSelection
                            ? Text(
                                'DESELECT',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 16),
                              )
                            : Text(
                                'SELECT',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                      ),
              ),
            ),
        viewModelBuilder: () =>
            SelectControlWidgetViewModel(deliveryJourney: deliveryJourney));
  }
}
