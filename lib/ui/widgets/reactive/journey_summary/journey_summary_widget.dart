import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:distributor/ui/widgets/icon_content.dart';
import 'package:distributor/ui/widgets/reactive/journey_summary/journey_summary_widget_viewmodel.dart';
import 'package:distributor/ui/widgets/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class JourneySummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneySummaryWidgetViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => model.isBusy
            ? BusyWidget()
            : Table(
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: ReusableCard(
                          color: Color.fromRGBO(49, 130, 243, 1),
                          cardChild: IconContent(
                            amount: model.deliveriesCompleted,
                            title: 'Deliveries\n Completed',
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.fill,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ReusableCard(
                              color: Color.fromRGBO(49, 130, 243, 1),
                              cardChild: IconContent(
                                amount: model.deliveriesPending,
                                title: 'Deliveries\n Pending',
                              ),
                            ),
                            Positioned(
                              top: 15,
                              right: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.indigo.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    model.ongoingJourney.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: ReusableCard(
                          color: Color.fromRGBO(49, 130, 243, 1),
                          cardChild: IconContent(
                            amount: model.paymehtsReceived,
                            title: 'Payments\n Received',
                          ),
                        ),
                      ),
                      TableCell(
                        child: ReusableCard(
                          color: Color.fromRGBO(49, 130, 243, 1),
                          cardChild: IconContent(
                            amount: model.ordersMade,
                            title: 'Orders\n Made',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
        viewModelBuilder: () => JourneySummaryWidgetViewModel());
  }
}
