import 'package:distributor/services/firestore_service.dart';
import 'package:injectable/injectable.dart';

abstract class RemoteStorageRepository {
  @factoryMethod
  factory RemoteStorageRepository() => FirestoreService();

  writeData(String endPoint, Map<String, dynamic> data);
  fetchData(String endPoint);
  deleteData();
  updateData(String endPoint, Map<String, dynamic> data);
  writeLocationData(Map<String, dynamic> locationData);
}
