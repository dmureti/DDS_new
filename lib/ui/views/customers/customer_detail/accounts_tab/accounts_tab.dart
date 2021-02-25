import 'package:badges/badges.dart';
import 'package:distributor/core/helper.dart';
import 'package:distributor/ui/views/customers/customer_detail/accounts_tab/accounts_tab_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class AccountsTab extends StatelessWidget {
  final Customer customer;
  const AccountsTab({@required this.customer, Key key})
      : assert(customer != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountsTabViewModel>.reactive(
        builder: (context, model, child) => model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: model.data == null
                    ? Center(
                        child: Text(
                          'This account does not have any account information.',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Column(
                        children: [
                          /// Container to filter tabs
//                          Container(
//                            color: kDarkBlue,
//                            child: Row(
//                              children: [
//                                IconButton(
//                                  icon: Icon(
//                                    Icons.sort_by_alpha,
//                                    color: model.sortAscending == false
//                                        ? Colors.white
//                                        : Colors.pink,
//                                  ),
//                                  splashColor: Colors.pink,
//                                  onPressed: () {
//                                    model.toggleSortByDate();
//                                  },
//                                )
//                              ],
//                            ),
//                          ),

                          /// Opening and closing balance
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Select Date Range'),
                                      model.isFiltered == false
                                          ? IconButton(
                                              onPressed: () {
                                                model.toggleShowDateSelection();
                                              },
                                              icon: Icon(Icons.filter_alt),
                                            )
                                          : Row(
                                              children: [
                                                model.showDateSelection == true
                                                    ? FlatButton.icon(
                                                        onPressed: () {
                                                          model.clear();
                                                          model
                                                              .toggleShowDateSelection();
                                                        },
                                                        label: Text('Clear'),
                                                        icon: Icon(Icons.clear),
                                                      )
                                                    : IconButton(
                                                        onPressed: () {
                                                          model
                                                              .toggleShowDateSelection();
                                                        },
                                                        icon: Badge(
                                                          child: Icon(
                                                              Icons.filter_alt),
                                                          showBadge: true,
                                                        ),
                                                      ),
                                              ],
                                            )
                                    ],
                                  ),
                                ),
                                model.showDateSelection == true
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                                onTap: () async {
                                                  var result =
                                                      await showDatePicker(
                                                          context: (context),
                                                          initialDate: model
                                                              .initialDate,
                                                          firstDate:
                                                              model.firstDate,
                                                          lastDate: model
                                                              .initialEndDate);
                                                  if (result is DateTime) {
                                                    model.updateStartDate(
                                                        result);
                                                  }
                                                },
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              child:
                                                                  Text('From'),
                                                              width: 50,
                                                            ),
                                                            Text(
                                                                '${Helper.formatDateForAccounts(model.startDate.toIso8601String())}'),
                                                          ],
                                                        ),
                                                        Icon(Icons
                                                            .arrow_drop_down)
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide
                                                                  .none,
                                                              left: BorderSide
                                                                  .none,
                                                              right: BorderSide
                                                                  .none),
                                                          color:
                                                              Colors.black45),
                                                    )
                                                  ],
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                                onTap: () async {
                                                  var result =
                                                      await showDatePicker(
                                                          context: (context),
                                                          initialDate: model
                                                              .initialDate,
                                                          firstDate:
                                                              model.firstDate,
                                                          lastDate:
                                                              model.lastDate);
                                                  if (result is DateTime) {
                                                    model.updateEndDate(result);
                                                  }
                                                },
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              child: Text('To'),
                                                              width: 50,
                                                            ),
                                                            Text(
                                                                '${Helper.formatDateForAccounts(model.endDate.toIso8601String())}'),
                                                          ],
                                                        ),
                                                        Icon(Icons
                                                            .arrow_drop_down)
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide
                                                                  .none,
                                                              left: BorderSide
                                                                  .none,
                                                              right: BorderSide
                                                                  .none),
                                                          color:
                                                              Colors.black45),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                Divider(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Opening Balance'),
                                          Text(
                                            'Kshs ${Helper.formatCurrency(model.customerAccount.openingBalance.balanceAmount)}',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Closing Balance'),
                                          Text(
                                            'Kshs ${Helper.formatCurrency(model.customerAccount.closingBalance.balanceAmount)}',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: model.customerTransactionList
                                    .where(
                                      (customerTransaction) =>
                                          DateTime.parse(
                                                  customerTransaction.entryDate)
                                              .isBefore(model.endDate
                                                  .add(Duration(days: 1))) &&
                                          DateTime.parse(
                                                  customerTransaction.entryDate)
                                              .isAfter(model.startDate
                                                  .subtract(Duration(days: 1))),
                                    )
                                    .toList()
                                    .length,
                                itemBuilder: (context, index) {
                                  CustomerTransaction c =
                                      model.customerTransactionList[index];
                                  if (DateTime.parse(c.entryDate).isBefore(model
                                          .endDate
                                          .add(Duration(days: 1))) &&
                                      DateTime.parse(c.entryDate).isAfter(model
                                          .startDate
                                          .subtract(Duration(days: 1)))) {
                                    return GestureDetector(
                                      onTap: () {},
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 8),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    c.description,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(Helper
                                                      .formatDateForAccounts(
                                                          c.entryDate)),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  c.debitAmount == 0.0
                                                      ? Text(
                                                          '- ${Helper.formatCurrency(c.creditAmount)} KES',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontSize: 18),
                                                        )
                                                      : Text(
                                                          '${Helper.formatCurrency(c.debitAmount)} KES',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                          )

                          /// Row of records
                        ],
                      )),
        viewModelBuilder: () => AccountsTabViewModel(customer: customer));
  }
}
