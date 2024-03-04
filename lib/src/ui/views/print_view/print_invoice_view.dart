import 'package:distributor/src/ui/views/print_view/print_invoice_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';

class PrintInvoiceView extends StatelessWidget {
  final invoice;
  final invoiceId;
  const PrintInvoiceView({Key key, this.invoice, this.invoiceId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PrintInvoiceViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, Widget) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Invoice'),
            actions: [],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return PdfPreview(
                  useActions: false,
                  allowSharing: false,
                  canChangePageFormat: false,
                  build: (format) => _generatePdf());
            },
          ),
        );
      },
      viewModelBuilder: () => PrintInvoiceViewModel(invoice, invoiceId),
    );
  }
}

Future<Uint8List> _generatePdf() async {}

_buildHeader() {}
_buildCustomerInfo() {}
_buildPaymentFooterInfo() {}
_buildItemsSection() {}
