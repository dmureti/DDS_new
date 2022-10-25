import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/helper.dart';
import 'package:distributor/ui/config/brand.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/dumb_widgets/empty_content_container.dart';
import 'package:distributor/ui/widgets/dumb_widgets/sku_suggestionTile.dart';

import 'package:distributor/ui/widgets/smart_widgets/sales_order_item/sales_order_item_widget.dart';
import 'package:distributor/ui/widgets/smart_widgets/sku_autocomplete/sku_autocomplete.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'sales_order_view_model.dart';

class CreateSalesOrderView extends StatelessWidget {
  final Customer customer;
  const CreateSalesOrderView({@required this.customer, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesOrderViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronLeft),
            onPressed: () async {
              Navigator.pop(context, false);
            },
          ),
          // bottom: PreferredSize(
          //   preferredSize: const Size.fromHeight(48.0),
          //   child: Container(
          //     child: Autocomplete<SalesOrderItem>(
          //       optionsBuilder: (TextEditingValue textEditingValue) {
          //         return model.salesOrderItems
          //             .where((SalesOrderItem salesOrderItem) => salesOrderItem
          //                 .item.itemName
          //                 .toLowerCase()
          //                 .startsWith(textEditingValue.text.toLowerCase()))
          //             .toList();
          //       },
          //       displayStringForOption: (SalesOrderItem salesOrderItem) =>
          //           salesOrderItem.item.itemName,
          //       fieldViewBuilder: (BuildContext context,
          //           TextEditingController fieldTextEditingController,
          //           FocusNode fieldFocusNode,
          //           VoidCallback onFieldSubmitted) {
          //         return Container(
          //           margin: EdgeInsets.symmetric(horizontal: 20),
          //           child: TextField(
          //             controller: fieldTextEditingController,
          //             focusNode: fieldFocusNode,
          //             style: const TextStyle(
          //               fontWeight: FontWeight.bold,
          //             ),
          //             decoration: InputDecoration(
          //                 prefixIcon: Icon(Icons.search), helperText: 'Search'),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),

          title: AppBarColumnTitle(
            mainTitle: 'Place Order',
            subTitle: customer.name,
          ),
          actions: <Widget>[],
          // bottom: model.isBusy
          //     ? TabBar(
          //         labelColor: Colors.pink,
          //         indicatorSize: TabBarIndicatorSize.tab,
          //         unselectedLabelColor: Colors.white.withOpacity(0.5),
          //         tabs: [
          //           Tab(
          //             child: Text('Available'),
          //           ),
          //           Tab(
          //             child: Text('All'),
          //           ),
          //         ],
          //       )
          //     : TabBar(
          //         labelColor: Colors.pink,
          //         indicatorSize: TabBarIndicatorSize.tab,
          //         unselectedLabelColor: Colors.white.withOpacity(0.5),
          //         tabs: [
          //           Tab(
          //             child: Text('Available (${model.availableProducts})'),
          //           ),
          //           Tab(
          //             child: Text('All (${model.totalNoOfProducts})'),
          //           ),
          //         ],
          //       ),
        ),
        body: model.isBusy
            ? Center(
                child: BusyWidget(),
              )
            : Column(
                children: [
                  Container(
                    height: 50,
                    // child: SearchBar(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2),
                      child: Material(
                        borderRadius: BorderRadius.circular(4),
                        elevation: 2,
                        type: MaterialType.card,
                        child: Row(
                          children: [
                            TextButton.icon(
                              onPressed: () => showSearch(
                                  context: context,
                                  delegate: SKUSearchDelegate(model)),
                              label: Text(
                                'Search by SKU',
                                style: TextStyle(color: Colors.grey),
                              ),
                              icon: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        _ResultsView(model.filterBySKU(model.skuSearchString))
                      ],
                    ),
                  ),
                  model.displaySummary
                      ? Container(
                          height: 200,
                          child: SummaryDraggableSheet(model, customer),
                        )
                      : Container()
                ],
              ),
      ),
      viewModelBuilder: () => SalesOrderViewModel(customer: customer),
      onModelReady: (model) => model.fetchProducts(),
    );
  }
}

class SummaryDraggableSheet extends StatefulWidget {
  final SalesOrderViewModel model;
  final Customer customer;

  SummaryDraggableSheet(this.model, this.customer);
  @override
  _SummaryDraggableSheetState createState() => _SummaryDraggableSheetState();
}

class _SummaryDraggableSheetState extends State<SummaryDraggableSheet> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  String _remarks = "";
  String get remarks => _remarks;
  _updateRemarks(String val) {
    setState(() {
      _remarks = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SummaryDraggableSheetViewModel>.reactive(
      viewModelBuilder: () => SummaryDraggableSheetViewModel(),
      builder: (context, model, child) => Container(
        color: kMutedYellowDark,
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Order Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        context: (context),
                        builder: (context) {
                          return SafeArea(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'REMARKS',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        onPressed: () => Navigator.pop(context),
                                        icon: Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  TextFormField(
                                    controller: _textEditingController,
                                    keyboardType: TextInputType.text,
                                    onChanged: (val) {
                                      _updateRemarks(val);
                                    },
                                    minLines: 5,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                        hintText: 'Any additional remarks'),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'SAVE REMARKS',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Icon(Icons.add_comment),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Date'),
                  widget.model.dueDate == null
                      ? Row(
                          children: [
                            Icon(AntDesign.exclamationcircleo),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Set due date'),
                          ],
                        )
                      : Row(
                          children: [
                            Text('${Helper.getDay(widget.model.dueDate)}')
                          ],
                        ),
                  GestureDetector(
                    child: Icon(Fontisto.date),
                    onTap: () async {
                      DateTime deliveryDate = await showDatePicker(
                          context: context,
                          initialDate: widget.model.initialDate,
                          firstDate: widget.model.firstDate,
                          lastDate: widget.model.lastDate);
                      if (deliveryDate != null) {
                        widget.model.setDueDate(deliveryDate);
                      }
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Items In Cart'),
                  Text(widget.model.salesOrderItems.length.toString())
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 2.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Credit Limit'),
            //       Text(
            //         'Kshs ${Helper.formatCurrency(widget.model.customer.creditLimit)}',
            //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Total'),
                  Text(
                    'Kshs ${Helper.formatCurrency(widget.model.total)}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                child: Text(
                  'Continue'.toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'ProximaNova500',
                      color: Colors.white,
                      fontSize: 18),
                ),
                onPressed: () {
                  SalesOrderRequest salesOrderRequest = SalesOrderRequest(
                      company: "",
                      customer: widget.customer.name,
                      total: widget.model.total,
                      dueDate: widget.model.dueDate,
                      items: widget.model.salesOrderItems,
                      orderType: "",
                      remarks: remarks,
                      sellingPriceList: widget.customer.defaultPriceList,
                      warehouse: widget.customer.branch);
                  widget.model.dueDate == null
                      ? showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  'DUE DATE REQUIRED',
                                  style: TextStyle(color: Colors.indigo),
                                ),
                                actions: <Widget>[
                                  TextButton.icon(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(Icons.close),
                                    label: Text('CLOSE'),
                                    // splashColor: Colors.indigo,
                                  )
                                ],
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.calendarAlt,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        'Please select a due date. Use the date selection button to set a due date.'),
                                  ],
                                ),
                              ))
                      : salesOrderRequest.items.isEmpty
                          ? showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'NO ITEMS ADDED',
                                  style: TextStyle(color: Colors.indigo),
                                ),
                                actions: <Widget>[
                                  TextButton.icon(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(Icons.close),
                                    label: Text('CLOSE'),
                                    // splashColor: Colors.indigo,
                                  )
                                ],
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                        'You have not added any items for ${salesOrderRequest.customer}. '),
                                  ],
                                ),
                              ),
                            )
                          : model.placeOrder(
                              customer: widget.customer,
                              salesOrderRequest: salesOrderRequest);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SummaryDraggableSheetViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  Future placeOrder(
      {Customer customer, SalesOrderRequest salesOrderRequest}) async {
    var result = await _navigationService.navigateTo(Routes.orderConfirmation,
        arguments: OrderConfirmationArguments(
            customer: customer, salesOrderRequest: salesOrderRequest));
    _navigationService.back(result: result);
  }
}

class SearchBar extends HookViewModelWidget<SalesOrderViewModel> {
  @override
  Widget buildViewModelWidget(
      BuildContext context, SalesOrderViewModel viewModel) {
    var searchString =
        useTextEditingController(text: viewModel.skuSearchString);
    return TextFormField(
      controller: searchString,
      keyboardType: TextInputType.text,
      // textInputAction: TextInputAction.en,
      onChanged: viewModel.updateSearchString,
      onTap: () => viewModel.toggleShowSummary(false),
      onFieldSubmitted: (val) => viewModel.onFieldSubmitted(val),
      onEditingComplete: () {
        //Happens when the user presses the action
        viewModel.onEditComplete();
        //Close the keyboard
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search for an SKU',
          suffixIcon: IconButton(
              onPressed: () => viewModel.resetSearch(),
              icon: Icon(Icons.cancel_outlined))),
    );
  }
}

class _ResultsView extends HookViewModelWidget<SalesOrderViewModel> {
  final List<Product> skuList;

  _ResultsView(this.skuList);
  @override
  Widget buildViewModelWidget(BuildContext context, SalesOrderViewModel model) {
    return skuList.isEmpty
        ? Center(
            child: EmptyContentContainer(
                label:
                    'There are no SKU items that match this ${model.skuSearchString}'),
          )
        : ListView.separated(
            physics: ClampingScrollPhysics(),
            separatorBuilder: (context, index) {
              return Divider(
                height: 0.1,
              );
            },
            shrinkWrap: true,
            itemCount: skuList.length,
            itemBuilder: (context, index) {
              return SalesOrderItemWidget(
                item: skuList[index],
                salesOrderViewModel: model,
              );
            });
  }
}

class SKUSearchDelegate extends SearchDelegate {
  final SalesOrderViewModel model;

  SKUSearchDelegate(this.model);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  List<Product> results = <Product>[];

  @override
  Widget buildResults(BuildContext context) {
    results = model.productList
        .where((element) => element.itemName
            .toLowerCase()
            .startsWith(query.trim().toLowerCase()))
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return SalesOrderItemWidget(
          item: results[index],
          salesOrderViewModel: model,
        );
      },
      itemCount: results.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> suggestions = model.productList
        .where((element) => element.itemName
            .toLowerCase()
            .startsWith(query.trim().toLowerCase()))
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            close(context, results);
          },
          child: SKUSuggestionTile(
            product: suggestions[index],
          ),
        );
      },
      itemCount: suggestions.length,
    );
  }
}
