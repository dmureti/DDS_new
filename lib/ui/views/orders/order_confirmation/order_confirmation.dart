import 'package:distributor/core/helper.dart';
import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:flutter/material.dart';

import 'order_confirmation_view_model.dart';

class OrderConfirmation extends StatelessWidget {
  final SalesOrderRequest salesOrderRequest;
  final Customer customer;

  const OrderConfirmation(
      {@required this.salesOrderRequest, @required this.customer, Key key})
      : assert(customer != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderConfirmationViewModel>.reactive(
      viewModelBuilder: () => OrderConfirmationViewModel(customer: customer),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronLeft),
            onPressed: () async {
              model.navigateToProductSelection();
            },
          ),
          title: Text('Order Summary'.toUpperCase()),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height - 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                elevation: 4,
                color: kColorMiniDarkBlue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customer'.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            salesOrderRequest.customer,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Due Date'.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '${Helper.getDay(salesOrderRequest.dueDate)}',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Number Of Items'.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '${salesOrderRequest.items.length}',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Remarks'.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              '${salesOrderRequest.remarks}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order Total'.toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            'Kshs ${Helper.formatCurrency(salesOrderRequest.total)}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Expanded(
                  child: ListView.separated(
                    itemCount: salesOrderRequest.items.length,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => Container(
                      height: 1,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    '${salesOrderRequest.items[index].quantity}',
                                    style: TextStyle(
                                        color: kColorMiniDarkBlue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 4.0, left: 4),
                                  child: Text('x'),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '${salesOrderRequest.items[index].item.itemName}',
                                style: TextStyle(
                                    color: kColorMiniDarkBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${Helper.formatCurrency((salesOrderRequest.items[index].quantity * salesOrderRequest.items[index].item.itemPrice))}',
                                  style: TextStyle(
                                      color: kColorMiniDarkBlue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                ClipOval(
                                  child: InkWell(
                                    splashColor: Colors.pink,
                                    child: Material(
                                      elevation: 4,
                                      type: MaterialType.card,
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.orange,
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
//              Text('Grand Total : ${salesOrderRequest.total}'),
                      model.isBusy
                          ? Column(
                              children: <Widget>[
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Please wait..saving order')
                              ],
                            )
                          : RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                model.createSalesOrder(salesOrderRequest);
                              },
                              child: Text(
                                'place order'.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
