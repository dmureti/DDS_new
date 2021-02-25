// Will maintain info about a user
import 'package:tripletriocore/tripletriocore.dart';

class UserService {
  User _user;
  User get user => _user;

  updateUser(User user) {
    _user = user;
  }
}
