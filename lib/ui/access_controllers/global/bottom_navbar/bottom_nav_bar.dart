import 'package:distributor/core/enums.dart';
import 'package:distributor/ui/access_controllers/global/bottom_navbar/bottom_navbar_viewmodel.dart';
import 'package:distributor/ui/views/home/home_viewmodel.dart';
import 'package:distributor/ui/widgets/reactive/bottom_bar_icon/bottom_bar_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BottomNavBar extends StatelessWidget {
  final Function onTap;
  final HomeViewModel homeViewModel;
  const BottomNavBar(
      {@required this.onTap, @required this.homeViewModel, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavBarViewModel>.reactive(
      onModelReady: (model) => model.init,
      builder: (context, model, child) => BottomNavigationBar(
          fixedColor: Colors.pink,
          iconSize: 70,
          type: BottomNavigationBarType.fixed,
          currentIndex: model.index,
          selectedIconTheme: IconThemeData(color: Colors.pink),
          unselectedIconTheme: (IconThemeData(color: Colors.white)),
          showUnselectedLabels: true,
          selectedLabelStyle:
              TextStyle(color: Colors.pink, fontWeight: FontWeight.w900),
          unselectedLabelStyle: TextStyle(color: Colors.indigo),
          items: [
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF182848),
              icon: ButtonBarIconButton(
                  onTap: onTap,
                  title: 'Home',
                  index: 0,
                  isEnabled: model.enableHomeTab,
                  page: Pages.home,
                  iconData: Icons.home,
                  updateIndex: model.updateIndex),
              label: 'Home'.toUpperCase(),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF182848),
              icon: IconButton(
                splashColor: Colors.pink,
                icon: Icon(Icons.swap_calls),
                onPressed: model.onJourneyTabTap()
                    ? () {
                        model.updateIndex(1);
                        onTap(Pages.routes, "Routes");
                      }
                    : null,
              ),
              label: 'Journey'.toUpperCase(),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF182848),
              icon: IconButton(
                splashColor: Colors.pink,
                icon: Icon(Icons.apps),
                onPressed: model.onStockBalanceTap()
                    ? () {
                        model.updateIndex(2);
                        onTap(Pages.products, "Stock Balance");
                      }
                    : null,
              ),
              label: 'Stock Balance'.toUpperCase(),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF182848),
              icon: IconButton(
                splashColor: Colors.pink,
                onPressed: model.onCustomerTabTap()
                    ? () {
                        model.updateIndex(3);
                        onTap(Pages.customers, "Customers");
                      }
                    : null,
                icon: Icon(Icons.people),
              ),
              label: 'Customers'.toUpperCase(),
            ),
          ]),
      viewModelBuilder: () => BottomNavBarViewModel(onTap),
    );
  }
}
