import 'package:badges/badges.dart';
import 'package:distributor/ui/access_controllers/global/bottom_navbar/bottom_nav_bar.dart';
import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:distributor/ui/views/adhoc_sales/adhoc_sales_view.dart';
import 'package:distributor/ui/views/customers/customer_view.dart';
import 'package:distributor/ui/views/dashboard/dashboard_view.dart';
import 'package:distributor/ui/views/home/home_viewmodel.dart';
import 'package:distributor/ui/views/routes/route_listing_view.dart';
import 'package:distributor/ui/views/stock/stock_view.dart';
import 'package:distributor/ui/widgets/drawer.dart';
import 'package:distributor/ui/widgets/reactive/map_icon_button/map_iconbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  final int index;

  const HomeView({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) async => await model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          actionsIconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          title: _buildTitle(model.currentIndex),
          actions: <Widget>[
            model.showPendingStockTransactionsIconButton
                ? IconButton(
                    icon: Icon(Icons.eleven_mp),
                    onPressed: () {},
                  )
                : Container(),
            IconButton(
              onPressed: () => model.refresh(),
              icon: Icon(FontAwesome.refresh),
            ),
            MapIconButton(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xFF182848),
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
        return DashboardView();
        break;
      case 1:
        return RoutesListingView();
        break;
      case 2:
        return AdhocSalesView();
        break;
      case 3:
        return StockView();
        break;
      case 4:
        return CustomerView();
        break;
      default:
        return DashboardView();
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
