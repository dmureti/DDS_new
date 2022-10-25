import 'package:distributor/ui/views/routes/route_listing_view_viewmodel.dart';
import 'package:distributor/ui/widgets/smart_widgets/info_bar_controller/info_bar_controller_view.dart';
import 'package:distributor/ui/widgets/smart_widgets/route_view_controller/route_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesListingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteListingViewModel>.reactive(
      viewModelBuilder: () => RouteListingViewModel(),
      builder: (context, model, child) => Container(
        child: Column(
          children: <Widget>[
            InfoBarController(),
            Divider(
              height: 2,
            ),
            RouteViewController()
          ],
        ),
      ),
    );
  }
}

//class SalesOrderPreviewTile extends StatelessWidget {
//  final SalesOrder salesOrder;
//  final DeliveryJourney deliveryJourney;
//  final String stopId;
//
//  SalesOrderPreviewTile(
//      {this.salesOrder,
//      @required this.deliveryJourney,
//      @required this.stopId,
//      Key key})
//      : assert(deliveryJourney != null),
//        super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Material(
//      elevation: 1,
//      child: ListTile(
//        onTap: () async {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => OrderDetailView(
//                      deliveryJourney: deliveryJourney,
//                      salesOrder: salesOrder,
//                      stopId: stopId)));
//        },
//        trailing: Text('${salesOrder.orderNo}'),
//        title: Text(salesOrder.customerName),
//        leading: salesOrder.orderStatus.contains('To Bill')
//            ? Icon(
//                FontAwesomeIcons.check,
//                color: Colors.pink,
//              )
//            : Icon(
//                FontAwesomeIcons.check,
//                color: Colors.grey.withOpacity(0.2),
//              ),
//      ),
//    );
//  }
//}

//class OrderDetail extends StatefulWidget {
//  final Order order;
//
//  OrderDetail({this.order});
//  @override
//  _OrderDetailState createState() => _OrderDetailState();
//}
//
//class _OrderDetailState extends State<OrderDetail> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          'Details for Order ${widget.order.orderNo}',
//          style: TextStyle(color: Colors.white),
//        ),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.edit),
//            onPressed: () {},
//          ),
//          IconButton(
//            icon: Icon(Icons.cancel),
//            onPressed: () {},
//          ),
//        ],
//      ),
//      body: Container(
//        margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Text(
//              'Overview',
//              style: TextStyle(fontSize: 18.0, color: Colors.pink),
//            ),
//            Divider(),
//            Text(
//              'Client Info',
//              style: TextStyle(fontSize: 18.0, color: Colors.pink),
//            ),
//            Divider(),
//            Text(
//              'Order Particulars',
//              style: TextStyle(fontSize: 18.0, color: Colors.pink),
//            ),
//            Divider(),
//            Text(
//              'Payment',
//              style: TextStyle(fontSize: 18.0, color: Colors.pink),
//            ),
//            Divider(),
//            Text(
//              'Client feedback',
//              style: TextStyle(fontSize: 18.0, color: Colors.pink),
//            ),
//            Divider(),
//          ],
//        ),
//      ),
//    );
//  }
//}
