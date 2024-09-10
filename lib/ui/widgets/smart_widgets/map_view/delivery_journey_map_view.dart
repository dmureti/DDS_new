import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:distributor/ui/widgets/dumb_widgets/journey_map_view_header.dart';
import 'package:distributor/ui/widgets/smart_widgets/distance_widget/distance_widget.dart';
import 'package:distributor/ui/widgets/smart_widgets/map_view/delivery_journey_map_view_viewmodel.dart';
import 'package:distributor/ui/widgets/smart_widgets/stops_widget/stops_list_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:tripletriocore/tripletriocore.dart';

class DeliveryJourneyMapView extends StatelessWidget {
  final DeliveryJourney deliveryJourney;

  DeliveryJourneyMapView({@required this.deliveryJourney, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ViewModelBuilder<DeliveryJourneyMapViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              extendBody: true,
              appBar: AppBar(
                title: Text('Journey Route Info'),
              ),
              body: model.isBusy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: height,
                      width: width,
                      child: Stack(
                        children: [
                          GoogleMapContainer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              JourneyMapViewHeader(
                                journeyId: model.deliveryJourney.journeyId,
                                journeyStatus: model.deliveryJourney.status,
                                route: model.deliveryJourney.route,
                                branch: model.deliveryJourney.branch,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Material(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
//                                              Text(
//                                                  'Zoom : ${model.zoom.toString()}'),
                                            _MapControl(AntDesign.minuscircleo,
                                                model.zoomOut),
                                            _MapControl(AntDesign.pluscircleo,
                                                model.zoomIn),
                                          ],
                                        ),
                                      ),
                                      Material(
                                        color: kColorMiniDarkBlue,
                                        elevation: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'ORDERS',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _JourneyOrder(model
                                                  .deliveryJourney.journeyId),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // List the orders here
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
            ),
        viewModelBuilder: () => DeliveryJourneyMapViewModel(deliveryJourney));
  }
}

class _MapControl extends HookViewModelWidget<DeliveryJourneyMapViewModel> {
  final IconData _iconData;
  final Function _onTap;

  _MapControl(this._iconData, this._onTap, {Key key})
      : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
      BuildContext context, DeliveryJourneyMapViewModel model) {
    return ClipOval(
      child: Material(
        child: InkWell(
          splashColor: Colors.pink,
          onTap: _onTap,
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(_iconData),
          ),
        ),
      ),
    );
  }
}

class _JourneyOrder extends HookViewModelWidget<DeliveryJourneyMapViewModel> {
  final String _journeyId;

  _JourneyOrder(this._journeyId, {Key key}) : super(key: key);
  @override
  Widget buildViewModelWidget(
      BuildContext context, DeliveryJourneyMapViewModel viewModel) {
    return ViewModelBuilder<StopsListWidgetViewModel>.reactive(
        onModelReady: (model) {
          model.init();
        },
        builder: (context, model, child) => model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : model.deliveryJourney == null
                ? Container(
                    child: Text(
                      'Fetching stops..',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Container(
                    child: Column(
                      children: model.deliveryJourney.stops
                          .where(
                              (deliveryStop) => deliveryStop.orderId.isNotEmpty)
                          .map<Widget>((deliveryStop) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${deliveryStop.customerId}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    FutureBuilder(
                                      future: model.fetchCustomerDetails(
                                          deliveryStop.customerId),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:

                                            ///@TODO : Add an animated container
                                            return Container();
                                            break;
                                          default:
                                            if (snapshot.hasError) {
                                              return Text(snapshot.error);
                                            } else {
                                              if (!snapshot.hasData)
                                                return Text('-');
                                              else {
                                                Customer _c = snapshot.data;
                                                UserLocation _customerLocation =
                                                    _c.customerLocation;
                                                viewModel.updateCustomers(_c);

                                                /// Add the coordinates
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    DistanceWidget(
                                                        _customerLocation,
                                                        viewModel
                                                            .currentPosition),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        ClipOval(
                                                          child: InkWell(
                                                            onTap: () {
                                                              viewModel.moveCameraTo(
                                                                  _customerLocation
                                                                      .latitude,
                                                                  _customerLocation
                                                                      .longitude);
                                                            },
                                                            child: Material(
                                                              color:
                                                                  Colors.white,
                                                              child: SizedBox(
                                                                width: 30,
                                                                height: 30,
                                                                child: Icon(Icons
                                                                    .location_searching),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              }
                                            }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
        viewModelBuilder: () =>
            StopsListWidgetViewModel(journeyId: _journeyId));
  }
}

class _RoutingWidget extends HookViewModelWidget<DeliveryJourneyMapViewModel> {
  @override
  Widget buildViewModelWidget(
      BuildContext context, DeliveryJourneyMapViewModel model) {
    var currentPositionController =
        useTextEditingController(text: model.currentAddress);
    return model.isBusy
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Text(model.currentPosition.latitude.toString()),
              TextField(
                controller: currentPositionController,
              )
            ],
          );
  }
}

class GoogleMapContainer
    extends HookViewModelWidget<DeliveryJourneyMapViewModel> {
  @override
  Widget buildViewModelWidget(
      BuildContext context, DeliveryJourneyMapViewModel model) {
    return GoogleMap(
        markers: model.markers != null ? Set<Marker>.from(model.markers) : null,

        /// Used for loading the map view on initial startup
        initialCameraPosition: model.initialLocation,

        /// Shows the location of the user on the map with a blue dot

        myLocationEnabled: model.myLocationEnabled,

        /// Used to bring the user location to the center of the camera view
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,

        /// Call back for when the map is ready to use
        onMapCreated: model.onMapCreated);
  }
}
