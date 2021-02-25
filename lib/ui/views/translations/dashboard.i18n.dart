import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, t);

  static var t = Translations("en") +
      {"en": "Welcome back", "en_us": "Welcome back"} +
      {"en": "Today\'s Summary", "en_us": "Today\'s Summary"} +
      {
        "en": "You have not been assigned any deliveries today.",
        "en_us": "You have not been assigned any deliveries today."
      };
}
