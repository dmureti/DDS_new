import 'package:distributor/conf/style/lib/colors.dart';
import 'package:distributor/core/helper.dart';
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
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class HomeView extends StatelessWidget {
  final int index;

  const HomeView({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.init(),
      fireOnModelReadyOnce: false,
      disposeViewModel: true,
      createNewModelOnInsert: true,
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
                : model.currentIndex == 3
                    ? PopupMenuButton(
                        onSelected: (value) =>
                            model.onStockBalancePopupSelected(value),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text('Pending Transactions'),
                            value: 0,
                          ),
                          PopupMenuItem(
                            child: Text('Return Stock'),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Text('Return Crates'),
                            value: 2,
                          )
                        ],
                      )
                    : Container(),

            // MapIconButton(),
          ],
        ),
        // floatingActionButton: model.currentIndex == 2
        //     ? SpeedDial(
        //         icon: Icons.shopping_cart_outlined,
        //         children: [
        //           SpeedDialChild(
        //             child: Icon(Icons.face),
        //             label: 'Walk In Customer',
        //             backgroundColor: Colors.amberAccent,
        //             onTap: () {/* Do someting */},
        //           ),
        //           SpeedDialChild(
        //             child: Icon(Icons.email),
        //             label: 'Contract Customer',
        //             backgroundColor: Colors.amberAccent,
        //             onTap: () {/* Do something */},
        //           ),
        //         ],
        //       )
        //     : Container(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: kHeroColor, visualDensity: VisualDensity.compact),
          child: BottomNavBar(
            homeViewModel: model,
            onTap: model.updateCurrentIndex,
            index: index,
          ),
        ),
        drawer: Drawer(
          child: CustomDrawer(),
        ),
        backgroundColor:
            model.currentIndex != 0 ? backgroundColor : Colors.white,
        body: model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _buildContent(model.currentIndex, model),
      ),
      viewModelBuilder: () => HomeViewModel(index),
    );
  }

  _buildContent(int index, HomeViewModel model) {
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
        return Column(
          children: [
            NetworkSensitiveWidget(),
            Container(
              height: 50,
              child: Material(
                elevation: 1,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ShowDateFilter(),
                    IconButton(
                      onPressed: model.toggleSortAsc,
                      icon: Icon(
                        Icons.sort,
                        color: model.sortAsc ? Colors.grey : Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: AdhocListingView()),
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

class ShowDateFilter extends HookViewModelWidget<HomeViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, HomeViewModel model) {
    return TextButton(
      child: Row(
        children: [
          Text(
            Helper.formatDate(model.startDate),
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.calendar_today,
            color: Colors.black,
          ),
        ],
      ),
      onPressed: () async {
        await showModalBottomSheet(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    children: [
                      Text('Select A Date'),
                      Row(
                        children: [
                          Container(
                            child: Text('Date'),
                            width: 100,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${Helper.formatDate(model.startDate)}'),
                                IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () async {
                                    var result = await showDatePicker(
                                        context: context,
                                        initialDate: model.startDate,
                                        firstDate: DateTime.now()
                                            .subtract(Duration(days: 365)),
                                        lastDate: DateTime.now());
                                    if (result is DateTime) {
                                      model.setStartDate(result);
                                      setState(() {});
                                      model.commitDateSelection();
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      // FlatButtonWidget(
                      //     label: 'Go', onTap: model.commitDateSelection)
                    ],
                  ),
                );
              });
            });
      },
    );
  }
}
