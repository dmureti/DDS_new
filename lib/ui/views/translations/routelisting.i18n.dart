import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, t);

  static var t = Translations("en") +
      {"en": "No journeys found.", "en_us": "No journeys found."} +
      {"en": "Today\'s Summary", "en_us": "Today\'s Summary"};
}
