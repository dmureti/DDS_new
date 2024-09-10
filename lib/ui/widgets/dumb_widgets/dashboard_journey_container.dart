import 'package:distributor/ui/widgets/reactive/journey_summary/journey_summary_widget.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar_controller/info_bar_controller_view.dart';
import 'package:flutter/material.dart';

class DashboardJourneyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoBarController(),
        _buildStyledContainer(),
        JourneySummaryWidget()
      ],
    );
  }

  _buildStyledContainer() {
    return Container(
      color: Colors.transparent,
      height: 10,
    );
  }
}
