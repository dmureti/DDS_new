import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:flutter/material.dart';

class JourneyMapViewHeader extends StatelessWidget {
  final String journeyId;
  final String journeyStatus;
  final String route;
  final String branch;

  const JourneyMapViewHeader(
      {@required this.journeyId,
      @required this.journeyStatus,
      @required this.route,
      @required this.branch,
      Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kColorMiniDarkBlue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Text(
                      journeyId,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Container(
                      child: Text(journeyStatus.toUpperCase(),
                          style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(branch, style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(route, style: TextStyle(color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
