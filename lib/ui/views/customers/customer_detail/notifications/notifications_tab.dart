import 'package:distributor/core/helper.dart';
import 'package:distributor/ui/views/customers/customer_detail/notifications/notifications_tab_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class NotificationsTab extends StatelessWidget {
  final Customer customer;
  const NotificationsTab({@required this.customer, Key key})
      : assert(customer != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationsTabViewModel>.reactive(
        onModelReady: (model) => model.getIssues(),
        builder: (context, model, child) => model.isBusy
            ? Center(child: CircularProgressIndicator())
            : Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  children: [
                    model.issueList == null || model.issueList.length == 0
                        ? Expanded(
                            child: Center(child: Text('No issues or requests')))
                        : Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                Issue issue = model.issueList[index];
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  child: Material(
                                    elevation: 2,
                                    child: ListTile(
                                      onTap: () {
                                        model.showDetailedIssueDialog(issue);
                                      },
                                      trailing: Text(
                                          Helper.formatDateForAccounts(
                                              issue.dateReported)),
                                      title: Row(
                                        children: [
                                          Text(issue.referenceNo),
                                          SizedBox(
                                            width: 8,
                                          ),
                                        ],
                                      ),
                                      subtitle: issue.subject != null
                                          ? Text(
                                              issue.subject,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Text(''),
                                    ),
                                  ),
                                );
                              },
                              itemCount: model.issueList.length,
                            ),
                          )
                  ],
                ),
              ),
        viewModelBuilder: () => NotificationsTabViewModel(customer: customer));
  }
}
