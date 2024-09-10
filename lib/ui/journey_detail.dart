import 'package:distributor/core/helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/core/viewmodels/delivery_journey_viewmodel.dart';
import 'package:distributor/ui/shared/widgets.dart';
import 'package:flutter/material.dart';

class JourneyDetail extends StatelessWidget {
  final DeliveryJourney deliveryJourney;

  const JourneyDetail({this.deliveryJourney, Key key})
      : assert(deliveryJourney != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeliveryJourneyViewmodel>.reactive(
      onModelReady: (model) async => await model.fetchDeliveryDetails(),
      viewModelBuilder: () => DeliveryJourneyViewmodel(
          deliveryJourneyId: deliveryJourney.journeyId),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Journey ${deliveryJourney.journeyId}'),
        ),
        body: model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: double.infinity,
                margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                      type: MaterialType.card,
                      color: Colors.white,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        InfoRow(
                                          title: 'ID',
                                          value: deliveryJourney.journeyId,
                                        ),
                                        Spacer(),
                                        Text(
                                          'Status: ${deliveryJourney.status}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    InfoRow(
                                      title: 'Branch',
                                      value: deliveryJourney.branch,
                                    ),
                                    InfoRow(
                                      title: 'Route',
                                      value: deliveryJourney.route,
                                    ),
                                    InfoRow(
                                      title: 'Date',
                                      value: Helper.getDay(
                                          deliveryJourney.deliveryDate),
                                    ),
                                    InfoRow(
                                      title: 'Orders ',
                                      value:
                                          deliveryJourney.orderCount.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Material(
                      type: MaterialType.card,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Stops'.toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blueGrey),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        model.deliveryStop.length.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    BuildStops()
                  ],
                ),
              ),
      ),
    );
  }
}

class BuildStops extends HookViewModelWidget<DeliveryJourneyViewmodel> {
  BuildStops({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
      BuildContext context, DeliveryJourneyViewmodel model) {
    return model.deliveryJourney.stops == 0
        ? Container(
            child: Text('No stops found'),
          )
        : ListView.builder(
            shrinkWrap: true,
            reverse: true,
            itemCount: model.deliveryJourney.stops.length,
            itemBuilder: (context, index) {
              return model.deliveryJourney.stops[index].orderId.length != 0
                  ? GestureDetector(
                      onTap: () async => model.navigateToSalesOrder(
                          salesOrder:
                              model.deliveryJourney.stops[index].orderId,
                          stopId: model.deliveryJourney.stops[index].stopId,
                          deliveryJourney: model.deliveryJourney),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        color: Colors.white,
                        child: Material(
                          type: MaterialType.card,
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              //@TODO: Take the user to the order
                              children: <Widget>[
                                Text(
                                  model.deliveryJourney.stops[index].orderId,
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  model.deliveryJourney.stops[index].customerId,
                                  style: TextStyle(fontSize: 14),
                                ),
//                        Text('${model.deliveryStop[index].index}'),
//                        Text('${model.deliveryStop[index].journeyId}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container();
            },
          );
  }
}
