import 'package:badges/badges.dart';
import 'package:distributor/ui/access_controllers/global/bottom_navbar/bottom_nav_bar.dart';
import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:distributor/ui/views/home/home_viewmodel.dart';
import 'package:distributor/ui/widgets/drawer.dart';
import 'package:distributor/ui/widgets/reactive/map_icon_button/map_iconbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) async => await model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          actionsIconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          title: Text(
            model.title,
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => model.refresh(),
              icon: Icon(FontAwesome.refresh),
            ),
            MapIconButton(),
            // IconButton(
            //   onPressed: model.navigateToNotificationsView,
            //   icon: Badge(
            //     toAnimate: true,
            //     badgeContent: Padding(
            //       padding: const EdgeInsets.all(3.0),
            //       child: Text(
            //         model.noOfUpdates,
            //         style: TextStyle(color: Colors.white, fontSize: 10),
            //       ),
            //     ),
            //     showBadge: model.hasActivityUpdate == true ? true : false,
            //     padding: EdgeInsets.all(3.0),
            //     position: BadgePosition(top: -10, end: -10),
            //     child: Icon(
            //       Icons.notifications,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            // IconButton(
            //   onPressed: null,
            //   icon: Icon(
            //     Icons.more_vert,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xFF182848),
          ),
          child: BottomNavBar(
            homeViewModel: model,
            onTap: model.updatePageToDisplay,
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
            : model.pageContent,
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
