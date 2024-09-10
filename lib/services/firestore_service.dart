import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:distributor/core/models/app_version.dart';
import 'package:distributor/services/remote_storage_repository.dart';

class FirestoreService implements RemoteStorageRepository {
  final _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference get _titleCollectionReference =>
      _firebaseFirestore.collection("titles");
  CollectionReference get _subjectCollectionReference =>
      _firebaseFirestore.collection("subject");
  CollectionReference get _orderCollectionReference =>
      _firebaseFirestore.collection("orders");
  CollectionReference get _bugCollectionReference =>
      _firebaseFirestore.collection('bugs');
  CollectionReference get _applicationCollectionReference =>
      _firebaseFirestore.collection('versions');

  checkForUpdates(String tenantId) async {
    return await _applicationCollectionReference
        .doc(tenantId)
        .get()
        .then((docSnapshot) => AppVersion.fromMap(docSnapshot.data()));
  }

  Future<List> fetchTitleList() async {
    return await _titleCollectionReference.orderBy('priority').get().then(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => docSnapshot.data())
            .toList());
  }

  Future fetchContentByTitleId(String titleId) async {
    await _titleCollectionReference.doc(titleId).get();
  }

  Future addBugReport() async {}

  ///
  /// Place and order
  /// Who placed it
  placeOrder(Map<String, dynamic> data) async {
    final _docRef = _orderCollectionReference.doc();
    data.addAll({"id": _docRef.id, "timestamp": FieldValue.serverTimestamp()});
    await _docRef.set(data);
  }

  placeIssue(Map<String, dynamic> data) async {
    try {
      var docRef = _bugCollectionReference.doc();
      data.addAll({"id": docRef.id});
      docRef.set(data);
    } catch (e) {
    } finally {}
  }

  @override
  deleteData() {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  fetchData(String endPoint) {
    // TODO: implement fetchData
    throw UnimplementedError();
  }

  @override
  updateData(String endPoint, Map<String, dynamic> data) {
    // TODO: implement updateData
    throw UnimplementedError();
  }

  @override
  writeData(String endPoint, Map<String, dynamic> data) {
    // TODO: implement writeData
    throw UnimplementedError();
  }

  @override
  writeLocationData(Map<String, dynamic> locationData) async {
    return _firebaseFirestore.collection('locations').add(locationData);
  }

  fetchFAQById(String itemId) async {
    return await _firebaseFirestore
        .collection('titles')
        .doc(itemId)
        .get()
        .then((docSnapshot) => docSnapshot.data());
  }

  void createGeoPoint(Map<String, dynamic> data, String journeyId) async {
    data.addAll({"timestamp": FieldValue.serverTimestamp()});
    await _firebaseFirestore
        .collection('locations')
        .doc(journeyId)
        .collection('markers')
        .add(data);
  }

  fetchMarkers(String journeyId) async {
    return _firebaseFirestore
        .collection('locations')
        .doc(journeyId)
        .collection('markers')
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((e) => e.data()).toList());
  }

  updateJourney(String journeyId, Map<String, dynamic> data) async {
    await _firebaseFirestore
        .collection('locations')
        .doc(journeyId)
        .set(data, SetOptions(merge: true));
  }
}
