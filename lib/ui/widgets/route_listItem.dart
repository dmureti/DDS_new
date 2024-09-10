import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/core/viewmodels/widgets/route_list_item.dart';
import 'package:distributor/ui/journey_detail.dart';
import 'package:distributor/ui/shared/widgets.dart';

import 'package:flutter/material.dart';

class RouteListItem extends StatelessWidget {
  final DeliveryJourney deliveryJourney;

  const RouteListItem({@required this.deliveryJourney, Key key})
      : assert(deliveryJourney != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteListItemViewmodel>.reactive(
      viewModelBuilder: () =>
          RouteListItemViewmodel(deliveryJourney: deliveryJourney),
      builder: (context, model, child) => Container(
        child: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => JourneyDetail(
                        deliveryJourney: model.deliveryJourney,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  width: double.infinity,
                  child: Material(
                    elevation: 4,
                    type: MaterialType.card,
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      InkWell(
                                        splashColor:
                                            Theme.of(context).colorScheme.secondary,
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  JourneyDetail(
                                                deliveryJourney:
                                                    model.deliveryJourney,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 130.0,
                                          child: Material(
                                            color: Colors.white,
                                            type: MaterialType.button,
                                            child: Text(
                                              '# ${model.deliveryJourney.journeyId}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        model.deliveryJourney.status,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: model.deliveryJourney.status
                                                    .toLowerCase()
                                                    .trim()
                                                    .contains('scheduled')
                                                ? Colors.pink
                                                : Colors.blueGrey),
                                      ),
//                                      IconButton(
//                                        icon: Icon(Icons.more_vert),
//                                        onPressed: () {
//                                          _showStopsModalSheet(context, model);
//                                        },
//                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  InfoRow(
                                    title: 'Branch',
                                    value: model.deliveryJourney.branch,
                                  ),
                                  InfoRow(
                                    title: 'Route',
                                    value: model.deliveryJourney.route,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      InfoRow(
                                        title: 'No of Orders : ',
                                        value: model.deliveryJourney.orderCount
                                            .toString(),
                                      ),
                                      Spacer(),
                                      InfoRow(
                                        title: 'Stops',
                                        value: (model.deliveryJourney.stops
                                                    .length -
                                                2)
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
