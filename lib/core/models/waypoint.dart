class Waypoint {
  final num _speed;
  final String _journeyId;
  final double _latitude;
  final double _longitude;
  final String _plateNum;
  final String _eventType;
  String _notes = "";
  final String _timestamp;

  String get timestamp => _timestamp;
  num get speed => _speed;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get plateNum => _plateNum;
  String get eventType => _eventType ?? "";
  String get notes => _notes ?? "";
  String get journeyId => _journeyId;

  Waypoint(
      {num speed,
      String journeyId,
      double latitude,
      double longitude,
      String plateNum,
      String eventType,
      String notes,
      String timestamp})
      : _speed = speed,
        _journeyId = journeyId,
        _latitude = latitude,
        _longitude = longitude,
        _plateNum = plateNum,
        _eventType = eventType,
        _notes = notes ?? "",
        _timestamp = timestamp;

  factory Waypoint.fromJson(Map<String, dynamic> data) {
    return Waypoint(
        speed: data['speed'],
        journeyId: data['journeyId'],
        longitude: data['longitude'],
        latitude: data['latitude'],
        eventType: data['eventType'] ?? "",
        notes: data['notes'] ?? "",
        plateNum: data['plateNum'] ?? "",
        timestamp: data['timestamp']);
  }

  factory Waypoint.fromMock() {
    return Waypoint();
  }

  Map<String, dynamic> toJson() {
    return {
      "speed": speed,
      "timestamp": DateTime.now().toIso8601String(),
      "journeyId": journeyId,
      "longitude": longitude,
      "latitude": latitude,
      "plateNum": plateNum,
      "eventType": eventType,
      "notes": notes,
    };
  }
}
