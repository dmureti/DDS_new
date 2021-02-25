class User {
  String creation;
  final String email;
  final int idx;
  String first_name;
  String last_name;
  String full_name;

  String token;

  User({this.idx, this.email, this.full_name});

  User.fromJson(Map<String, dynamic> parsedjson, String otherStuff)
      : email = parsedjson['email'],
        full_name = parsedjson['full_name'],
        idx = parsedjson['idx'],
        token = otherStuff;

  User.fromSavedPref(String email, String full_name, int idx, String token)
      : email = email,
        full_name = full_name,
        idx = idx,
        token = token;
}
