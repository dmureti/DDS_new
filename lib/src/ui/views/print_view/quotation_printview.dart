import 'dart:typed_data';

import 'package:distributor/core/helper.dart';
import 'package:distributor/src/ui/views/print_view/quotation_printviewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';

class QuotationPrintView extends StatelessWidget {
  final quotation;
  final quotationId;
  final List quotationItems;
  const QuotationPrintView(
      {Key key, this.quotation, this.quotationId, this.quotationItems});

  @override
  Widget build(BuildContext context) {
    final String fontRoot = "assets/fonts/proxima_nova/normal/proxima.ttf";
    final double fontSize = 60.5;
    return ViewModelBuilder<QuotationPrintViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Quotation'),
            actions: [
              IconButton(
                onPressed: () => _print(model, fontRoot, fontSize,
                    quotationItems, quotationId, quotation),
                icon: Icon(Icons.print),
              )
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              double height = constraints.maxHeight * PdfPageFormat.mm;
              double margin = 5 * PdfPageFormat.mm;
              double marginTop = 5 * PdfPageFormat.mm;
              double marginBottom = 5 * PdfPageFormat.mm;

              return PdfPreview(
                  useActions: false,
                  allowSharing: false,
                  canChangePageFormat: false,
                  // build: (format) => _generatePdf(
                   build: (format) async => await _generatePdf(
                      format.copyWith(
                        marginLeft: margin,
                        marginRight: margin,
                        marginTop: marginTop,
                        marginBottom: marginBottom,
                      ),
                      model,
                      quotationItems,
                      quotationId,
                      quotation,
                      height,
                      fontRoot,
                      fontSize),
                  pageFormats: <String, PdfPageFormat>{
                    'roll57': PdfPageFormat.roll57,
                    'A4': PdfPageFormat.a4,
                    'Letter': PdfPageFormat.letter,
                  });
            },
          ),
        );
      },
      viewModelBuilder: () => QuotationPrintViewModel(quotation, quotationId),
    );
  }
}

_print(QuotationPrintViewModel model, String fontRoot, double fontSize,
    List quotationItems, String quotationNumber, var quotation) async {
  final font = await rootBundle.load(fontRoot);
  final ttf = pw.Font.ttf(font);
  final width = PdfPageFormat.roll57.availableWidth * PdfPageFormat.mm;
  final marginBottom = 15.0 * PdfPageFormat.mm;
  final marginLeft = 0.0 * PdfPageFormat.mm;
  final marginRight = 0.0 * PdfPageFormat.mm;
  final pdf = pw.Document(compress: true);
  final pw.TextStyle style = pw.TextStyle(
    font: ttf,
    fontSize: fontSize,
  );
  List<pw.Widget> widgets = [];
  _buildWidgetTree() {
    List<pw.Widget> tree = [
      _buildSellersDetail(style),
      pw.Divider(thickness: 1.5),
      _buildCustomerInfo(model, quotationNumber, quotation),
      pw.SizedBox(height: 10),
      pw.Divider(thickness: 1.5),
      ..._buildItemsSection(quotationItems, model, style),
      pw.Divider(thickness: 1.5),
      pw.SizedBox(height: 10),
      _buildTaxInfo(model),
      pw.Divider(thickness: 1.5),
      pw.SizedBox(height: 10),
      pw.SizedBox(height: 10),
      _buildPaymentFooterInfo(),
      pw.SizedBox(height: 20),
      pw.Divider(
        thickness: 2.0,
      )
    ];
    widgets.addAll(tree);
  }

  _buildWidgetTree();
  pdf.addPage(
    pw.Page(
      theme: pw.ThemeData(
          paragraphStyle: pw.TextStyle(fontSize: fontSize, font: ttf),
          defaultTextStyle: pw.TextStyle(fontSize: fontSize, font: ttf)),
      pageFormat: PdfPageFormat.roll57.copyWith(
          width: width * 2.65,
          marginBottom: marginBottom,
          marginLeft: marginLeft,
          marginRight: marginRight),
      build: (pw.Context context) => pw.Center(
        child: pw.Column(
            mainAxisSize: pw.MainAxisSize.max,
            children: widgets,
            crossAxisAlignment: pw.CrossAxisAlignment.stretch),
      ),
    ),
  );
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

_buildSellersDetail(
  pw.TextStyle textStyle,
) {
  return pw.Column(children: [
    pw.SizedBox(height: 5),
    pw.Text('DEMO COMPANY LIMITED'.toUpperCase(), style: textStyle),
    pw.Text('P.O BOX 00000-00020 Nairobi'.toUpperCase(), style: textStyle),
    pw.Text('info@democompanylimited.co.ke', style: textStyle),
    pw.Text('Tel:0719555999,0737644430,0732', style: textStyle),
    pw.Text("PIN : XXXXXXXXX", style: textStyle),
    pw.SizedBox(height: 5),
  ]);
}

Future<Uint8List> _generatePdf(
    PdfPageFormat format,
    QuotationPrintViewModel model,
    List quotationItems,
    quotationNumber,
    var quotation,
    double widgetHeight,
    String fontRoot,
    double fontSize) async {
  final font = await rootBundle.load(fontRoot);
  final ttf = pw.Font.ttf(font);
  final width = PdfPageFormat.roll57.width * PdfPageFormat.mm;
  final marginBottom = 10.0 * PdfPageFormat.mm;
  final marginLeft = 5.0 * PdfPageFormat.mm;
  final marginRight = 5.0 * PdfPageFormat.mm;
  final pdf = pw.Document(compress: true);
  final pw.TextStyle style = pw.TextStyle(
    font: ttf,
    fontSize: fontSize,
  );
  List<pw.Widget> widgets = [];
  _buildWidgetTree() {
    List<pw.Widget> tree = [
      _buildTitle(),
      _buildCustomerInfo(model, quotationNumber, quotation),
      pw.SizedBox(height: 10),
      ..._buildItemsSection(quotationItems, model, style),
      pw.SizedBox(height: 10),
      _buildTaxInfo(model),
      pw.SizedBox(height: 10),
      pw.SizedBox(height: 10),
      _buildPaymentFooterInfo()
    ];
    widgets.addAll(tree);
  }

  _buildWidgetTree();
  pdf.addPage(
    pw.Page(
        theme: pw.ThemeData(
            header0: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            paragraphStyle: pw.TextStyle(fontSize: fontSize),
            defaultTextStyle: pw.TextStyle(fontSize: fontSize)),
        pageFormat: PdfPageFormat.roll57.copyWith(
            width: width,
            marginBottom: marginBottom,
            marginLeft: marginLeft,
            marginRight: marginRight),
        build: (pw.Context context) => pw.Center(
            child: pw.Column(
                mainAxisSize: pw.MainAxisSize.max,
                children: widgets,
                crossAxisAlignment: pw.CrossAxisAlignment.stretch))),
  );
  return pdf.save();
}

///
/// The type of document
///
_buildTitle() {
  return pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
    pw.Text('Quotation',
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 40))
  ]);
}

///
/// Customer information
///
_buildCustomerInfo(
    QuotationPrintViewModel model, String quotationNo, var quotation) {
  return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Row(children: [
          pw.Text('Customer : '),
          pw.Text(model.quotation['customer']['name']),
          // pw.Text('KRA PIN Number')
        ], crossAxisAlignment: pw.CrossAxisAlignment.start),
        pw.Row(children: [
          pw.Text("Quotation No: ${quotationNo}"),
        ], crossAxisAlignment: pw.CrossAxisAlignment.start),
        pw.Row(children: [
          pw.Text(
              "Document Date: ${Helper.formatDateFromString(DateTime.now().toIso8601String())}"),
        ]),
        pw.Column(
          children: [
            pw.Row(children: [
              pw.SizedBox(height: 5),
            ], crossAxisAlignment: pw.CrossAxisAlignment.start)
          ],
        ),
      ]);
}

_buildTaxInfo(QuotationPrintViewModel model) {
  return pw.Column(children: [
    pw.SizedBox(height: 10),
    pw.Row(
      children: [
        pw.Text("Payment Term"),
        pw.Text("Cash"),
      ],
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    ),
    pw.Column(children: [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Discount Amount : '),
          pw.Text('${model.quotation['discount'].toStringAsFixed(2)}'),
        ],
      ),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('VAT Amount : '),
          pw.Text('${model.tax.toStringAsFixed(2)}'),
        ],
      ),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Withholding VAT : '),
          pw.Text(
              '${model.quotation['withHoldingTax']?.toStringAsFixed(2) ?? ""}'),
        ],
      ),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Total Amount : '),
          pw.Text('${model.total.toStringAsFixed(2)}'),
        ],
      ),
      pw.SizedBox(height: 10),
    ], crossAxisAlignment: pw.CrossAxisAlignment.start),
  ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween);
}

///
/// Render the payment information
///
_buildPaymentFooterInfo() {
  return pw.Column(children: [
    pw.Text(
        'Pay To Bank: Demo Company Limited Bank: Local Bank (Kenya) Limited Branch:'),
    pw.Text('Cemo Account number: 1340280343168'),
    pw.Text('Swift No. DemoSwiftNo'),
    pw.Text('Pay to Mpesa: Till Number : Demo Till'),
    pw.SizedBox(height: 10),
    pw.Text(
        'Terms: Goods once sold cannot be returned. All goods belong to Demo Limited until fully paid for. Signed Terms of Trade Apply.',
        textAlign: pw.TextAlign.center),
  ]);
}

_buildItemData(List items, QuotationPrintViewModel model, pw.TextStyle style) {
  List<TableRow> _rows = <TableRow>[];
  return items
      .map((item) => pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 2),
          child: pw.Column(children: [
            pw.Row(children: [
              pw.Expanded(
                flex: 3,
                child: pw.Text(item['itemName'].toString().toUpperCase(),
                    style: style),
              ),
            ]),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  width: 30,
                  child: pw.Text(item['itemCode'],
                      style: style, textAlign: pw.TextAlign.left),
                ),
                pw.SizedBox(width: 10),
                pw.Container(
                  width: 20,
                  child: pw.Text(item['quantity'].toString(),
                      style: style, textAlign: pw.TextAlign.right),
                ),
                pw.SizedBox(width: 5),
                pw.Container(
                  child: pw.Text(Helper.formatCurrency(item['itemPrice']),
                      style: style, textAlign: pw.TextAlign.right),
                ),
                pw.SizedBox(width: 5),
                pw.Container(
                    child: pw.Text(
                        Helper.formatCurrency(
                            (item['itemPrice'] * item['quantity'])),
                        style: style,
                        textAlign: pw.TextAlign.left))
              ],
            ),
          ])))
      .toList();
}

_buildItemsSection(
    List items, QuotationPrintViewModel model, pw.TextStyle style) {
  return _buildItemData(items, model, style);
}

_drawQRCode(QuotationPrintViewModel model) {
  return pw.Center(
    child: pw.BarcodeWidget(
      color: PdfColor.fromHex("#000000"),
      barcode: pw.Barcode.qrCode(),
      data: "",
      width: 50,
      height: 50,
    ),
  );
}
