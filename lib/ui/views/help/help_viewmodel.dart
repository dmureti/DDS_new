import 'package:distributor/app/locator.dart';
import 'package:distributor/services/firestore_service.dart';
import 'package:stacked/stacked.dart';

class HelpViewModel extends BaseViewModel {
  //@TODO Convert to a repository
  final _firestoreService = locator<FirestoreService>();

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
}
