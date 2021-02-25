import 'package:distributor/core/models/delivery_report_status.dart';
import 'package:distributor/core/models/price.dart';

class DeliveryReportBody {
  String bulkId;
  String callbackData;
  String doneAt;
  DeliveryReportStatus error;
  String messageId;
  Price price;
  String sentAt;
  String smsCount;
  DeliveryReportStatus status;
  String to;

  DeliveryReportBody(
      {this.bulkId,
      this.callbackData,
      this.doneAt,
      this.error,
      this.messageId,
      this.price,
      this.sentAt,
      this.smsCount,
      this.status,
      this.to});

  factory DeliveryReportBody.fromMap(Map<String, dynamic> data) {
    return DeliveryReportBody(
        bulkId: data['bulkId'],
        callbackData: data['callbackData'],
        doneAt: data['doneAt'],
        error: data['error'],
        messageId: data['messageId'],
        price: data['price'],
        sentAt: data['sentAt'],
        smsCount: data['smsCount'],
        status: data['status'],
        to: data['to']);
  }

  toJson() {
    return {
      "bulkId": bulkId,
      "callbackData": callbackData,
      "doneAt": doneAt,
      "error": error.toJson(),
      "messageId": messageId,
      "price": price.toJson(),
      "sentAt": sentAt,
      "smsCount": smsCount,
      "status": status.toJson(),
      "to": to
    };
  }
}
