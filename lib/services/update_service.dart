import 'package:injectable/injectable.dart';

@lazySingleton

/// Will handle checking for updates
class UpdateService {
  bool _isLatest = true;
  bool get isLatest => _isLatest;
}
