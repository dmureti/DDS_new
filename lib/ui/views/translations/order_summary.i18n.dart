import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, t);

  static var t = Translations("en") +
      {"en": "Order Summary", "en_us": "Order Summary"} +
      {
        "en": "Customer",
        "en_us": "Customer",
      } +
      {
        "en": "Due Date",
        "en_us": "Due Date",
      } +
      {
        "en": "No Of Items",
        "en_us": "No Of Items",
      } +
      {
        "en": "place order",
        "en_us": "place order",
      } +
      {
        "en": "total",
        "en_us": "total",
      };
}
