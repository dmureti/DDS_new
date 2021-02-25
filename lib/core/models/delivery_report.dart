import 'package:distributor/core/models/delivery_report_body.dart';

class DeliveryReport {
  List<DeliveryReportBody> results;

  DeliveryReport({this.results});

  factory DeliveryReport.fromMap(List<Map<String, dynamic>> data) {
    List<DeliveryReportBody> results;
    //Loop through every element of the List
    data.forEach((f) {
      results.add(DeliveryReportBody.fromMap(f));
    });
    return DeliveryReport(results: results);
  }

  toJson() {
    List resultSet = [];
    results.forEach((f) {
      resultSet.add(f.toJson());
    });
    return {"results": resultSet};
  }
}
