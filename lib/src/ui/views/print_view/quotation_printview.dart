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
  const QuotationPrintView({Key key, this.quotation, this.quotationId});

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
              double height = constraints.maxHeight * PdfPageFormat.mm;
              double width = constraints.maxWidth;
              // const width = 2.28346457 * PdfPageFormat.inch;
              double margin = 5 * PdfPageFormat.mm;
              double marginTop = 5 * PdfPageFormat.mm;
              double marginBottom = 5 * PdfPageFormat.mm;
              double printHeight = 300.0 * PdfPageFormat.mm;
              return PdfPreview(
                useActions: false, allowSharing: false,
                canChangePageFormat: false,
                // actions: [
                //   PdfPreviewAction(
                //       icon: Icon(Icons.print), onPressed: (format)=>_print();)
                // ],
                // onPrinted: (_) => model.finalizeOrder(),
                // maxPageWidth: MediaQuery.of(context).size.width,
                // initialPageFormat: PdfPageFormat.a4,
                build: (format) => _generatePdf(
                    format.copyWith(
                      // height: height * 0.74,
                      // width: width,
                      marginLeft: margin,
                      marginRight: margin,
                      marginTop: marginTop,
                      marginBottom: marginBottom,
                    ),
                    "Quotation",
                    model,
                    height,
                    fontRoot,
                    fontSize),
                pageFormats: <String, PdfPageFormat>{
                  'roll57': PdfPageFormat.roll57,
                  'A4': PdfPageFormat.a4,
                  'Letter': PdfPageFormat.letter,
                },
              );
            },
          ),
        );
      },
      viewModelBuilder: () => QuotationPrintViewModel(quotation, quotationId),
    );
  }
}

Future<Uint8List> _generatePdf(
    PdfPageFormat format,
    String title,
    QuotationPrintViewModel model,
    double widgetHeight,
    String fontRoot,
    double fontSize) async {
  List<pw.Widget> widgets = [];
  final font = await rootBundle.load(fontRoot);
  final ttf = pw.Font.ttf(font);
  const imageProvider = const AssetImage('assets/images/fourSum-logo.png');
  final image = await flutterImageProvider(imageProvider);
  final width = PdfPageFormat.roll57.width * PdfPageFormat.mm;
  final marginBottom = 10.0 * PdfPageFormat.mm;
  final marginLeft = 5.0 * PdfPageFormat.mm;
  final marginRight = 5.0 * PdfPageFormat.mm;
  final pdf = pw.Document(compress: true);
  final pw.TextStyle style = pw.TextStyle(
    font: ttf,
    fontSize: fontSize,
  );
  _buildWidgetTree() {
    List<pw.Widget> tree = [
      // _buildPrintRef(model, style),
      _buildHeader(image, model, style),
      // _buildSectionHeader("Sellers Detail", style),
      _buildSellersDetail(model.user, style, model),
      _buildSectionHeader("Buyers Details", style),
      _buildBuyerDetails(model, style),
      _buildSectionHeader("Goods and Services Details", style),
      ..._buildGoodsAndServices(model.quotation['items'], style),
      _buildSpacer(),
      _buildSectionHeader("Tax Details", style),
      _buildTaxDetails(model, style),
      _buildSectionHeader(
          "Summary", style.copyWith(fontWeight: pw.FontWeight.bold)),
      _buildSummary(model, style),
      _buildSpacer(),
      _buildFooter(model, style),
      // _buildSpacer(),
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

_print(QuotationPrintViewModel model, String fontRoot, double fontSize) async {
  var result = true;
  final font = await rootBundle.load(fontRoot);
  final ttf = pw.Font.ttf(font);
  if (result) {
    const imageProvider = const AssetImage('assets/images/fourSum-logo.png');
    final image = await flutterImageProvider(imageProvider);
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
        // _buildPrintRef(model, style),
        _buildHeader(image, model, style),
        _buildSectionHeader("Sellers Detail", style),
        _buildSellersDetail(model.user, style, model),
        // _buildSectionHeader("URA Information", style),
        // _buildURAInformation(style, model),
        _buildSectionHeader("Buyers Details", style),
        _buildBuyerDetails(model, style),
        _buildSectionHeader("Goods and Services Details", style),
        ..._buildGoodsAndServices(model.quotation['items'], style),
        _buildSpacer(),
        _buildSectionHeader("Tax Details", style),
        _buildTaxDetails(model, style),
        _buildSectionHeader("Summary", style),
        _buildSummary(model, style),
        pw.SizedBox(height: 20),
        // _drawQRCode(model),
        pw.SizedBox(height: 20),
        _buildFooter(model, style),
        _buildSpacer(),
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
              // width: PdfPageFormat.roll80.width * PdfPageFormat.mm,
              marginBottom: marginBottom,
              marginLeft: marginLeft,
              marginRight: marginRight),
          build: (pw.Context context) => pw.Center(
              child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.max,
                  children: widgets,
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch))),
    );
    var result = await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}

///
/// Build the header of the invoice
///
_buildHeader(
    pw.ImageProvider image, QuotationPrintViewModel model, pw.TextStyle style) {
  return pw.Row(children: [
    pw.Padding(
      child: pw.Container(
          child: pw.Image(image, height: 70), width: 100, height: 70),
      padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    ),
    // pw.Placeholder(fallbackHeight: 50, fallbackWidth: 50),
    pw.SizedBox(width: 20),
    pw.Column(children: [
      pw.Text("Quotation",
          style: style.copyWith(fontSize: 18, fontWeight: pw.FontWeight.bold)),
      pw.Row(
        children: [
          pw.Text("Date: ", style: style),
          pw.Text("${Helper.formatToTime(model.dateTime)} ", style: style),
          pw.Text("${Helper.formatDate(model.dateTime)} ", style: style),
        ],
      )
    ], crossAxisAlignment: pw.CrossAxisAlignment.start)
  ]);
}

_buildBuyerDetails(QuotationPrintViewModel model, pw.TextStyle style) {
  return pw.Column(children: [
    pw.Row(children: [
      pw.Text('Customer Name :', style: style),
      pw.Text(model.quotation['customer']['customerName'] ?? "", style: style)
    ]),
  ]);
}

_buildGoodsAndServices(List deliveryItems, pw.TextStyle style) {
  return deliveryItems.map((deliveryItem) {
    num deliveredQty =
        deliveryItem['deliveredQty'] ?? deliveryItem['quantity'] ?? 0.0;
    num total = deliveredQty * deliveryItem['itemRate'];
    if (deliveredQty > 0.0) {
      return pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: 2),
        child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Row(children: [
                pw.Expanded(
                  flex: 3,
                  child: pw.Text(deliveryItem['itemName'], style: style),
                ),
              ]),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(
                    width: 20,
                    child: pw.Text(deliveredQty.toString(),
                        style: style, textAlign: pw.TextAlign.right),
                  ),
                  pw.SizedBox(width: 5),
                  // pw.Expanded(
                  //   flex: 3,
                  //   child: pw.Text(deliveryItem['itemName'],
                  //       style: style.copyWith(
                  //           fontWeight: pw.FontWeight.bold, fontSize: 16)),
                  // ),
                  pw.Container(
                    child: pw.Text('${deliveryItem['itemRate']}'.toString(),
                        style: style, textAlign: pw.TextAlign.right),
                  ),
                  pw.SizedBox(width: 5),
                  pw.Container(
                      child: pw.Text(Helper.formatCurrency(total),
                          style: style, textAlign: pw.TextAlign.left))
                ],
              ),
            ]),
      );
    } else {
      return pw.Container(height: 0);
    }
  }).toList();
}

_buildSectionHeader(final String sectionHeader, pw.TextStyle style) {
  return pw.Column(children: [
    pw.Divider(thickness: 1.5),
    pw.Text(sectionHeader, style: style),
    pw.Divider(thickness: 1.5),
  ]);
}

_buildSellersDetail(
  User user,
  pw.TextStyle textStyle,
  QuotationPrintViewModel model,
) {
  var deliveryNoteId = model.quotationId;
  return pw.Column(children: [
    // _buildSpacer(),
    pw.SizedBox(height: 5),
    pw.Text('FOURSUM LIMITED'.toUpperCase(), style: textStyle),
    pw.Text('P.O BOX 64443-00620 Nairobi'.toUpperCase(), style: textStyle),
    pw.Text('Email Address: info@foursumlimited.co.ke', style: textStyle),
    pw.Text('Tel:0719555999,0737644430,0732', style: textStyle),
    pw.Text("PIN : P051969170B", style: textStyle),
    pw.Text(user.branch.toUpperCase(), style: textStyle),
    _buildSpacer(),
    pw.Row(
      children: [
        pw.Text('Transaction Id : ', style: textStyle),
        pw.Text('${model.quotationId}', style: textStyle),
      ],
    ),
    pw.Row(
      children: [
        pw.Text('Transaction Date : ', style: textStyle),
        pw.Text('${model.quotation['dueDate']}'),
      ],
    ),
    pw.Row(
      children: [
        pw.Text('Generated By : ', style: textStyle),
        pw.Text(user.full_name, style: textStyle),
      ],
    ),
  ]);
}

_buildSpacer() {
  return pw.SizedBox(height: 10);
}

_buildFooter(QuotationPrintViewModel model, pw.TextStyle style) {
  return pw.Column(children: [
    _buildSpacer(),
    // pw.Center(
    //   child: pw.Text(model.deviceId, style: style),
    // ),
    pw.SizedBox(height: 2),
    pw.Text("Powered by DDS ver:${model.versionCode}", style: style)
  ], crossAxisAlignment: pw.CrossAxisAlignment.center);
}

_buildSummary(QuotationPrintViewModel model, pw.TextStyle style) {
  return pw.Column(children: [
    pw.SizedBox(height: 5),
    pw.Row(children: [
      pw.Text('Net Amount', style: style),
      _buildCurrencyWidget(model.net, style),
    ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween),
    pw.Row(children: [
      pw.Text('Tax Amount', style: style),
      _buildCurrencyWidget(model.tax, style),
    ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween),
    pw.Row(children: [
      pw.Text('Gross Amount', style: style),
      _buildCurrencyWidget(model.gross, style),
    ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween),
    pw.SizedBox(height: 5),
    pw.Row(
        children: [pw.Text('Currency', style: style), pw.Text(model.currency)],
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween),
  ]);
}

_buildTaxDetails(QuotationPrintViewModel model, pw.TextStyle style) {
  return pw.Column(children: [
    pw.SizedBox(height: 5),
    pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Text('Tax Category : ', style: style),
        pw.Text('A: Standard (${(model.taxRate * 100).toStringAsFixed(0)}%)',
            style: style),
      ],
    ),
    pw.SizedBox(height: 3),
    pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text('Net Amt', style: style),
        pw.Text('Tax Amt', style: style),
        pw.Text('Gross Amt', style: style),
      ],
    ),
    pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        _buildCurrencyWidget(model.net, style),
        _buildCurrencyWidget(model.tax, style),
        _buildCurrencyWidget(model.gross, style),
      ],
    ),
  ]);
}

_buildCurrencyWidget(
  num val,
  pw.TextStyle style,
) {
  return pw.Text('${Helper.formatCurrency(val)}', style: style);
}

///
/// Build printer information
/// Build version info
///

_drawQRCode(QuotationPrintViewModel model) {
  return pw.Center(
    child: pw.BarcodeWidget(
      // drawText: true,
      color: PdfColor.fromHex("#000000"),
      barcode: pw.Barcode.qrCode(),
      data: "",
      // data: "This is a test",
      width: 300,
      height: 300,
    ),
  );
}
