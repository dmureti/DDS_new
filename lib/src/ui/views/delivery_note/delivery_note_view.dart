import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'delivery_note_viewmodel.dart';

class DeliveryNoteView extends StatelessWidget {
  final DeliveryJourney deliveryJourney;
  final DeliveryStop deliveryStop;

  const DeliveryNoteView({Key key, this.deliveryJourney, this.deliveryStop})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeliveryNoteViewModel>.reactive(
        builder: (context, model, child) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text('Summary'),
                    ),
                    Tab(
                      child: Text('Particulars'),
                    )
                  ],
                ),
              ),
              body: TabBarView(
                children: [Container(), Container()],
              ),
            ),
          );
        },
        viewModelBuilder: () =>
            DeliveryNoteViewModel(deliveryJourney, deliveryStop));
  }
}
