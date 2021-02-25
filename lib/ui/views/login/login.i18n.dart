import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, t);

  static var t = Translations("en") +
      {"en": "Sign in", "en_us": "Sign in"} +
      {"en": "Remember me", "en_us": "Remember Me"} +
      {
        "en": "Forgot Password",
        "en_us": "Forgot Password",
      } +
      {"en": "Version", "en_us": "Version"} +
      {
        "en": "Please enter your email address",
        "en_us": "Please enter your email address"
      } +
      {"en": "Sign In Failed : ", "en_us": "Could not sign you in"} +
      {"en": "Signing in as", "en_us": "Logging in as"} +
      {
        "en": "Please enter a password. The password cannot be empty.",
        "en_us": "Please enter a password. The password cannot be empty."
      };
}
