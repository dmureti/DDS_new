import 'package:distributor/app/locator.dart';
import 'package:distributor/src/ui/views/pos/base_pos_viewmodel.dart';
import 'package:distributor/src/ui/views/pos/confirm_cart/confirm_cart_view.dart';
import 'package:distributor/src/ui/views/pos/item_view/pos_item_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class POSViewmodel extends BasePOSViewModel {
  final _navigationService = locator<NavigationService>();
  List itemsInCart = [];
  List items = [];
  List views = ['Grid', 'List'];

  bool isToggled = false;

  init() async {
    setBusy(true);
    items = await fetchItems();
    setBusy(false);
  }

  String _view;
  String get view => _view ?? views.first;
  toggleView() {
    if (view.toLowerCase() == 'grid') {
      _view = views.last;
      isToggled = true;
    } else {
      _view = views.first;
      isToggled = false;
    }
    notifyListeners();
  }

  addItemToCart() async {}
  removeItemFromCart() async {}

  void search() async {}
  void sort() async {}
  void vert() async {}
}
