import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, t);

  static var t = Translations("en") +
      {"en": "No journeys found", "en_us": "No journeys found"} +
      {
        "en": "Stock information not available.",
        "en_us": "Stock information not available."
      } +
      {"en": "No customers found.", "en_us": "No customers found."};
}
