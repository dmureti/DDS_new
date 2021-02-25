import 'package:distributor/core/models/delivery_stop.dart';

class DeliveryJourney {
  String branch;
  String deliveryDate;
  String driver;
  String driverName;
  String journeyId;
  int orderCount;
  String route;
  String status;
  List<DeliveryStop> stops;
  String turnBoy;
  String turnBoyName;
  String vehicle;

  DeliveryJourney(
      {this.status,
      this.branch,
      this.deliveryDate,
      this.driver,
      this.driverName,
      this.journeyId,
      this.orderCount,
      this.route,
      this.stops,
      this.turnBoy,
      this.turnBoyName,
      this.vehicle});

  factory DeliveryJourney.fromMap({Map data}) {
    List<DeliveryStop> stops = [];
    List deliveryStoprawData = data['stops'];
    print(deliveryStoprawData.length);
    deliveryStoprawData.forEach((f) {
      return stops.add(DeliveryStop.fromMap(f));
    });
    return DeliveryJourney(
        status: data['status'] ?? "",
        branch: data['branch'] ?? "",
        deliveryDate: data['deliveryDate'],
        driver: data['driver'],
        driverName: data['driverName'],
        journeyId: data['journeyId'],
        orderCount: data['orderCount'],
        route: data['route'],
        stops: stops, // @TODO : Convert to a list of DeliveryStopObjects
        turnBoy: data['turnboy'],
        turnBoyName: data['turnboyName'],
        vehicle: data['vehicle']);
  }

  toJson() {
    return {
      "branch": branch,
      "deliveryDate": deliveryDate,
      "driver": driver,
      "driverName": driverName,
      "journeyId": journeyId,
      "orderCount": orderCount,
      "route": route,
      "status": status,
      "stops": stops, //@TODO convert this to json
      "turnBoy": turnBoy,
      "turnBoyName": turnBoyName,
      "vehicle": vehicle
    };
  }
}
