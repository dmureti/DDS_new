import 'package:distributor/core/viewmodels/widgets/map_widget_viewmodel.dart';
import 'package:distributor/ui/widgets/smart_widgets/distance_widget/distance_widget.dart';
import 'package:distributor/ui/widgets/smart_widgets/placemark_widget/placemark_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:tripletriocore/tripletriocore.dart';

class MapWidget extends StatelessWidget {
  final UserLocation userLocation;
  final UserLocation customerLocation;
  final Customer customer;

  MapWidget({this.userLocation, this.customerLocation, this.customer});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewmodel>.reactive(
      viewModelBuilder: () => MapViewmodel(
          start: userLocation, end: customerLocation, customer: customer),
      onModelReady: (model) async {
//        await model.init();
      },
      builder: (context, model, child) => Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: GoogleMap(
              mapToolbarEnabled: true,
              myLocationEnabled: true, myLocationButtonEnabled: true,
              mapType: MapType.normal,
//              polylines: Set<Polyline>.of(model.polylines.values),
              markers: model.markers != null
                  ? Set<Marker>.from(model.markers)
                  : null,
              initialCameraPosition: model.initialPosition,
              onMapCreated: (GoogleMapController controller) {
                model.controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildCustomerDetail extends HookViewModelWidget<MapViewmodel> {
  _BuildCustomerDetail({Key key}) : super(key: key);
  @override
  Widget buildViewModelWidget(BuildContext context, MapViewmodel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.customer.name),
        PlaceMarkWidget(model.getCoordinates(model.customer)),
        model.data is UserLocation
            ? DistanceWidget(model.getCoordinates(model.customer), model.data)
            : Container(
                child: Text('mambo'),
              ),
      ],
    );
  }
}
