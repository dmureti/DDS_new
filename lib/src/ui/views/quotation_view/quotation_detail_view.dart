import 'package:distributor/src/ui/views/quotation_view/quotation_detail_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/app_bar_column_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class QuotationDetailView extends StatelessWidget {
  final quotation;
  const QuotationDetailView({Key key, this.quotation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuotationDetailViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: AppBarColumnTitle(
              mainTitle: quotation['customer']['customer_name'],
              subTitle: quotation['id'],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.share),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.print),
              )
            ],
          ),
        );
      },
      viewModelBuilder: () => QuotationDetailViewModel(quotation),
    );
  }
}
