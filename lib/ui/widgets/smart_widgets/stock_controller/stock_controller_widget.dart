import 'package:distributor/ui/widgets/dumb_widgets/no_journey_container.dart';
import 'package:distributor/ui/widgets/smart_widgets/stock_controller/stock_controller_widget_viewmodel.dart';
import 'package:distributor/ui/widgets/smart_widgets/stock_list_widget/stock_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StockControllerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StockControllerWidgetViewModel>.reactive(
        builder: (context, model, child) => model.hasJourneys == false
            ? NoJourneyContainer()
            : model.hasSelectedJourney == true
                ? StockListWidget()
                : _buildCenterContainer('You have not selected a journey.'),
        viewModelBuilder: () => StockControllerWidgetViewModel());
  }

  _buildCenterContainer(String text) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: (Text(text)),
          ),
        ],
      ),
    );
  }
}
