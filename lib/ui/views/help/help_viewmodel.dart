import 'package:distributor/app/locator.dart';
import 'package:distributor/services/firestore_service.dart';
import 'package:distributor/ui/views/help/help_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:distributor/app/router.gr.dart';

class HelpViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  final String _id;

  HelpViewModel({String id}) : this._id = id;
  String get id => _id;

  //@TODO Convert to a repository
  final _firestoreService = locator<FirestoreService>();

  fetchDocumentById(String itemId) async {
    setBusy(true);
    _helpDetail = await _firestoreService.fetchFAQById(itemId);
    setBusy(false);
    notifyListeners();
  }

  Map<String, dynamic> _helpDetail;
  Map<String, dynamic> get helpDetail => _helpDetail;

  List _items = [];
  List get items => _items;

  init() async {
    await fetchHelpItems();
  }

  String _helpString;
  String get helpString => _helpString;

  fetchHelpItems() async {
    setBusy(true);
    var result = await _firestoreService.fetchTitleList();
    _items = result;
    setBusy(false);
  }

  fetchContent() async {}

  navigateToDetail(String id, String title) async {
    await navigationService.navigateTo(Routes.helpDetailView,
        arguments: HelpDetailViewArguments(id: id, title: title));
  }
}
