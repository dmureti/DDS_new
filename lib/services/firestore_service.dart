import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference get _titleCollectionReference =>
      _firebaseFirestore.collection("titles");
  CollectionReference get _subjectCollectionReference =>
      _firebaseFirestore.collection("subject");
  CollectionReference get _orderCollectionReference =>
      _firebaseFirestore.collection("orders");
  CollectionReference get _bugCollectionReference =>
      _firebaseFirestore.collection('bugs');

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
}
