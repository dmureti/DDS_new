import 'package:distributor/ui/views/bug_report/bug_report_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BugReportView extends StatelessWidget {
  const BugReportView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BugReportViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Report App Issue'),
              ),
            ),
        viewModelBuilder: () => (BugReportViewModel()));
  }
}
