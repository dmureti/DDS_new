import 'package:distributor/src/ui/common/network_sensitive_widget.dart';
import 'package:distributor/src/ui/views/adhoc_listing/adhoc_listing_view.dart';
import 'package:distributor/ui/access_controllers/global/bottom_navbar/bottom_nav_bar.dart';
import 'package:distributor/ui/shared/brand_colors.dart';

import 'package:distributor/ui/views/customers/customer_view.dart';
import 'package:distributor/ui/views/dashboard/dashboard_view.dart';
import 'package:distributor/ui/views/home/home_viewmodel.dart';
import 'package:distributor/ui/views/routes/route_listing_view.dart';
import 'package:distributor/ui/views/stock/stock_view.dart';
import 'package:distributor/ui/widgets/drawer.dart';
import 'package:distributor/ui/widgets/fragments/master_detail_page.dart';
import 'package:distributor/ui/widgets/reactive/map_icon_button/map_iconbutton.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  final int index;

  const HomeView({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          actionsIconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          title: _buildTitle(model.currentIndex),
          actions: <Widget>[
            // IconButton(
            //   onPressed: () => model.refresh(),
            //   icon: Icon(FontAwesome.refresh),
            // ),
            model.currentIndex == 2
                ? IconButton(
                    onPressed: () {
                      model.navigateToAddAdhocSale();
                    },
                    icon: Icon(Icons.add_circle_outline),
                    tooltip: 'Add Adhoc Sale',
                  )
                : Container(),

            MapIconButton(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xFF303891),
          ),
          child: BottomNavBar(
            homeViewModel: model,
            onTap: model.updateCurrentIndex,
            index: index,
          ),
        ),
        drawer: Drawer(
          child: CustomDrawer(),
        ),
        backgroundColor: backgroundColor,
        body: model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _buildContent(model.currentIndex),
      ),
      viewModelBuilder: () => HomeViewModel(index),
    );
  }

  _buildContent(int index) {
    switch (index) {
      case 0:
        return Stack(
          children: [
            NetworkSensitiveWidget(),
            DashboardView(),
          ],
        );
        break;
      case 1:
        return Stack(
          children: [
            NetworkSensitiveWidget(),
            RoutesListingView(),
          ],
        );
        break;
      case 2:
        return Stack(
          children: [
            NetworkSensitiveWidget(),
            AdhocListingView(),
          ],
        );
        // return AdhocSalesView();
        break;
      case 3:
        return Column(
          children: [
            NetworkSensitiveWidget(),
            Expanded(child: StockView()),
          ],
        );
        break;
      case 4:
        return Column(
          children: [
            NetworkSensitiveWidget(),
            Expanded(child: CustomerView()),
          ],
        );
        break;
      default:
        return Column(
          children: [
            NetworkSensitiveWidget(),
            DashboardView(),
          ],
        );
        break;
    }
  }

  _buildTitle(int index) {
    switch (index) {
      case 0:
        return Text(
          'Home',
          style: TextStyle(color: Colors.white),
        );
        break;
      case 1:
        return Text(
          'Journey',
          style: TextStyle(color: Colors.white),
        );
        break;
      case 2:
        return Text(
          'Adhoc Sales',
          style: TextStyle(color: Colors.white),
        );
        break;
      case 3:
        return Text(
          'Stock Balance',
          style: TextStyle(color: Colors.white),
        );
        break;
      case 4:
        return Text(
          'Customers',
          style: TextStyle(color: Colors.white),
        );
        break;
      default:
        return Text(
          'Home',
          style: TextStyle(color: Colors.white),
        );
        break;
    }
  }
}
