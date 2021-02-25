import 'package:injectable/injectable.dart';

@lazySingleton
class SearchService {
  String _query = "";
  String get query => _query;
  updateQuery(String val) {
    _query = val;
  }
}
