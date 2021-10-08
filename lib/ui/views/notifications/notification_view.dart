import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:distributor/ui/views/notifications/notification_view_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Notification'),
              ),
              body: Container(
                color: Colors.white,
                child: model.appActivity.length > 0
                    ? ListView.builder(
                        itemCount: model.appActivity.length,
                        itemBuilder: (context, index) =>
                            _buildActivityContainer(model.appActivity[index]))
                    : Text('Nothing to report'),
              ),
            ),
        viewModelBuilder: () => NotificationViewModel());
  }

  _buildActivityContainer(Activity activity) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Material(
        type: MaterialType.card,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    activity.activityTitle,
                    style: TextStyle(
                        color: kColorMiniDarkBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    timeago.format(activity.activityTime),
                    style: TextStyle(color: Colors.pink),
                  ),
                ],
              ),
              Text(activity.activityDesc),
            ],
          ),
        ),
      ),
    );
  }
}
