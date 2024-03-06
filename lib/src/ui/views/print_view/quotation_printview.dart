import 'package:distributor/core/helper.dart';
import 'package:distributor/src/ui/views/print_view/quotation_printviewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:tripletriocore/tripletriocore.dart';

class QuotationPrintView extends StatelessWidget {
  final quotation;
  final quotationId;
  final List quotationItems;
  const QuotationPrintView(
      {Key key, this.quotation, this.quotationId, this.quotationItems});

  @override
  Widget build(BuildContext context) {
    final String fontRoot = "assets/fonts/proxima_nova/normal/proxima.ttf";
    final double fontSize = 39.5;
    return ViewModelBuilder<QuotationPrintViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Quotation'),
            actions: [
              IconButton(
                onPressed: () => _print(model, fontRoot, fontSize),
                icon: Icon(Icons.print),
              )
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return PdfPreview(
                useActions: false,
                allowSharing: false,
                canChangePageFormat: false,
                build: (format) => _generatePdf(
                  model,
                ),
              );
            },
          ),
        );
      },
      viewModelBuilder: () => QuotationPrintViewModel(quotation, quotationId),
    );
  }
}

_print(QuotationPrintViewModel model, String fontRoot, double fontSize) async {
  final font = await rootBundle.load(fontRoot);
  final ttf = pw.Font.ttf(font);
  const imageProvider = const AssetImage('assets/images/fourSum-logo.png');
  final image = await flutterImageProvider(imageProvider);
  final pdf = pw.Document(compress: true);
  List<pw.Widget> widgets = [];
  _buildWidgetTree() {
    List<pw.Widget> tree = [
      _buildTitle(),
      _buildHeader(image),
      _buildCustomerInfo(model),
      pw.SizedBox(height: 10),
      _buildItemsSection([], model),
      pw.SizedBox(height: 10),
      _buildTaxInfo(),
      pw.SizedBox(height: 10),
      _buildValidationSection(),
      pw.SizedBox(height: 10),
      _buildPaymentFooterInfo()
    ];
    widgets.addAll(tree);
  }

  _buildWidgetTree();
  pdf.addPage(pw.Page());
  var result = await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

Future<Uint8List> _generatePdf(QuotationPrintViewModel model) async {
  const imageProvider = const AssetImage('assets/images/fourSum-logo.png');
  final image = await flutterImageProvider(imageProvider);
  final pdf = pw.Document(compress: true);
  List<pw.Widget> widgets = [];
  _buildWidgetTree() {
    List<pw.Widget> tree = [
      _buildTitle(),
      _buildHeader(image),
      _buildCustomerInfo(model),
      pw.SizedBox(height: 10),
      _buildItemsSection([], model),
      pw.SizedBox(height: 10),
      _buildTaxInfo(),
      pw.SizedBox(height: 10),
      _buildValidationSection(),
      pw.SizedBox(height: 10),
      _buildPaymentFooterInfo()
    ];
    widgets.addAll(tree);
  }

  _buildWidgetTree();
  pdf.addPage(pw.Page(
    build: (pw.Context context) => pw.Center(
      child: pw.Column(
          mainAxisSize: pw.MainAxisSize.max,
          children: widgets,
          crossAxisAlignment: pw.CrossAxisAlignment.stretch),
    ),
  ));
  var result = await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

///
/// The type of document
///
_buildTitle() {
  return pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
    pw.Text('Quotation',
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18))
  ]);
}

///
/// Branding anc 4Sum contact info
///
_buildHeader(pw.ImageProvider image) {
  return pw.Row(children: [
    pw.Column(children: [
      pw.Padding(
        child: pw.Container(
            child: pw.Image(image, height: 150), width: 200, height: 200),
        padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      ),
    ]),
    pw.Column(children: [
      pw.Text('FOURSUM LIMITED'),
      pw.Text('P.O BOX 64443-00620 Nairobi'),
      pw.Text('Email Address: info@foursumlimited.co.ke'),
      pw.Text('Tel:0719555999,0737644430'),
      pw.Text('PIN:P051969170B'),
    ], crossAxisAlignment: pw.CrossAxisAlignment.start),
  ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween);
}

///
/// Customer information
///
_buildCustomerInfo(QuotationPrintViewModel model) {
  return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(children: [
          pw.Text('Customer'),
          pw.Text(''),
          pw.Text('KRA PIN Number')
        ], crossAxisAlignment: pw.CrossAxisAlignment.start),
        pw.Column(children: [_drawQRCode(model)]),
        pw.Column(
          children: [
            pw.Row(children: [
              pw.Text("Invoice Number: "),
              pw.Text(""),
              pw.Row(children: [pw.Text("Control Code: "), pw.Text('')]),
              pw.Row(children: [pw.Text("CU Serial Number: "), pw.Text('')]),
              pw.Row(children: [pw.Text("Due date: "), pw.Text('')]),
              pw.Row(children: [pw.Text("Your Reference: "), pw.Text('')]),
              pw.Row(children: [pw.Text("Delivery Mode: "), pw.Text('')]),
              pw.Row(children: [pw.Text("Contact Person Mode: "), pw.Text('')]),
            ], crossAxisAlignment: pw.CrossAxisAlignment.start)
          ],
        )
      ]);
}

_buildTaxInfo() {
  return pw.Row(children: [
    pw.Column(children: [
      pw.Text("Payment Term : Cash"),
    ]),
    pw.Column(children: [
      pw.Row(
        children: [
          pw.Text('Total Before VAT:'),
          pw.Text('KES '),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Discount Amount : '),
          pw.Text(''),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('VAT Amount : '),
          pw.Text(''),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Withholding VAT : '),
          pw.Text('KES 0.00'),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Total Amount : '),
          pw.Text(''),
        ],
      )
    ], crossAxisAlignment: pw.CrossAxisAlignment.start),
  ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween);
}

_buildValidationSection() {
  return pw.Row(children: [
    pw.Column(children: [
      pw.Text('Prepared By'),
      pw.Text('Approved By Finance'),
      pw.Text('Dispatched By'),
      pw.Text('Delivered By'),
      pw.Text('Received By'),
    ], crossAxisAlignment: pw.CrossAxisAlignment.start),
    pw.Column(children: [
      pw.Text('Signature'),
      pw.Text('Signature'),
      pw.Text('Signature'),
      pw.Text('Vehicle Reg No'),
      pw.Text('Signature'),
    ], crossAxisAlignment: pw.CrossAxisAlignment.start),
    pw.Column(children: [
      pw.Text('Date'),
      pw.Text('Date'),
      pw.Text('Date'),
      pw.Text('Signature'),
      pw.Text('Date'),
    ], crossAxisAlignment: pw.CrossAxisAlignment.start),
  ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween);
}

///
/// Render the payment information
///
_buildPaymentFooterInfo() {
  return pw.Column(children: [
    pw.Text(
        'Pay To Bank: Foursum Limited Bank: Equity Bank (Kenya) Limited Branch:'),
    pw.Text('Eastleigh Account number: 1340280343168'),
    pw.Text('Swift No. EQBLKENA'),
    pw.Text('Pay to Mpesa: Till Number : 8375158'),
    pw.Text(
        'Terms: Goods once sold cannot be returned. All goods belong to Foursum Limited until fully paid for. Signed Terms of Trade Apply.'),
  ]);
}

_buildItemData(List items, QuotationPrintViewModel model) {
  List<TableRow> _rows = <TableRow>[];
  return items
      .map((item) => pw.TableRow(children: [
            pw.Text(item['itemCode']),
            pw.Text(item['itemName']),
            pw.Text(item['quantity'].toString()),
            pw.Text(item['itemRate'].toString()),
            pw.Text(""),
            pw.Text('0.00'),
            pw.Text('16.00'),
            pw.Text(""),
            pw.Text(""),
          ]))
      .toList();
}

_buildItemsSection(List items, QuotationPrintViewModel model) {
  pw.TableRow header = pw.TableRow(
    children: [
      pw.Text('Item'),
      pw.Text('Description'),
      pw.Text('Qty'),
      pw.Text('Price(VATInc)'),
      pw.Text('Price(VATExc)'),
      pw.Text('Disc'),
      pw.Text('Tax%'),
      pw.Text('VAT Total'),
      pw.Text('Total(VAT Inc)')
    ],
  );
  List<pw.TableRow> _itemDataRows = _buildItemData(items, model);
  List<pw.TableRow> itemsSectionData = [header];
  itemsSectionData.addAll(_itemDataRows);
  return pw.Table(children: itemsSectionData);
}

_drawQRCode(QuotationPrintViewModel model) {
  return pw.Center(
    child: pw.BarcodeWidget(
      // drawText: true,
      color: PdfColor.fromHex("#000000"),
      barcode: pw.Barcode.qrCode(),
      data: "",
      // data: "This is a test",
      width: 50,
      height: 50,
    ),
  );
}
