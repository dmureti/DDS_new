mixin Validator {
  String checkIdentificationType(var value) {
    if (value.toString().contains('@')) {
      return "email";
    } else {
      return "mobile";
    }
  }
}
