import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, t);

  static var t = Translations("en") +
      {
        "en": "New Order",
        "en_us": "New Order",
      } +
      {
        "en": "Set due date",
        "en_us": "Set due date",
      } +
      {
        "en": "Delivery Date",
        "en_us": "Due Date",
      } +
      {
        "en": "Items In Cart",
        "en_us": "Items In Cart",
      } +
      {
        "en": "Total",
        "en_us": "Total",
      } +
      {
        "en": "Checkout",
        "en_us": "Checkout",
      };
}
