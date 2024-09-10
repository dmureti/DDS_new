import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:distributor/ui/views/customer_location_viewmodel.dart';
import 'package:distributor/ui/widgets/map_widget.dart';
import 'package:distributor/ui/widgets/smart_widgets/distance_widget/distance_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CustomerLocation extends StatelessWidget {
  final Customer customer;

  CustomerLocation({this.customer});

  @override
  Widget build(BuildContext context) {
    List<String> coord = customer.gpsLocation.split(',');
    double latitude = double.parse(coord[0]);
    double longitude = double.parse(coord[1]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Contact Info'),
        actions: [],
      ),
      body: ViewModelBuilder<CustomerLocationViewModel>.reactive(
          builder: (context, model, child) => model.dataReady
              ? Container(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            color: kColorMiniDarkBlue,
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              title: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Customer',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '${customer.name}',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      _StartTextField(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      _DestinationTextField(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      Text('Distance : ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          DistanceWidget(
                                                              model
                                                                  .userLocation,
                                                              UserLocation(
                                                                  latitude:
                                                                      latitude,
                                                                  longitude:
                                                                      longitude)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton(
                                                      color: Colors.pink,
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      icon: Icon(
                                                          Icons.directions),
                                                      onPressed: () {}),
                                                ],
                                              ),
//                                        IconButton(
//                                          icon: Icon(
//                                            Icons.my_location,
//                                            color: Colors.white,
//                                          ),
//                                          onPressed: () {},
//                                        )
                                            ],
                                          ),
                                        ),
                                      ),
//                                  RaisedButton(
//                                    onPressed: () async {},
//                                    child: Text('SHOW ROUTE'),
//                                  )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: MapWidget(
                              userLocation: model.userLocation,
                              customerLocation: UserLocation(
                                  latitude: latitude, longitude: longitude),
                              customer: customer,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          viewModelBuilder: () => CustomerLocationViewModel(
              UserLocation(latitude: latitude, longitude: longitude))),
    );
  }
}

class _StartTextField extends HookViewModelWidget<CustomerLocationViewModel> {
  @override
  Widget buildViewModelWidget(
      BuildContext context, CustomerLocationViewModel model) {
    var startAddress = useTextEditingController(text: model.currentAddress);
    return TextField(
      style: TextStyle(color: kColorMiniDarkBlue),
      controller: startAddress,
      decoration: InputDecoration(filled: true, fillColor: Colors.white),
    );
  }
}

class _DestinationTextField
    extends HookViewModelWidget<CustomerLocationViewModel> {
  @override
  Widget buildViewModelWidget(
      BuildContext context, CustomerLocationViewModel model) {
    var stopAddress = useTextEditingController(text: model.destinationAddress);
    return TextField(
      style: TextStyle(color: kColorMiniDarkBlue),
      controller: stopAddress,
      decoration: InputDecoration(filled: true, fillColor: Colors.white),
    );
  }
}
