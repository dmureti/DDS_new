import 'package:distributor/core/helper.dart';
import 'package:distributor/core/models/invoice.dart';
import 'package:distributor/src/ui/views/print_view/print_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class PrintView extends StatelessWidget {
  final String title;
  final Invoice invoice;
  final User user;
  var deliveryNote;
  String orderId;
  List items;

  PrintView(
      {Key key,
      this.invoice,
      this.title,
      @required this.deliveryNote,
      this.user,
      this.orderId = "",
      List items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PrintViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              IconButton(
                  onPressed: () => _printDirect(model), icon: Icon(Icons.print))
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              double height = constraints.maxHeight * PdfPageFormat.mm;
              double width = constraints.maxWidth;
              // const width = 2.28346457 * PdfPageFormat.inch;
              double margin = 5 * PdfPageFormat.mm;
              double marginTop = 8 * PdfPageFormat.mm;
              double marginBottom = 8 * PdfPageFormat.mm;
              double printHeight = 300.0 * PdfPageFormat.mm;
              return PdfPreview(
                onPrinted: (_) => model.finalizeOrder(),
                maxPageWidth: MediaQuery.of(context).size.width,
                // initialPageFormat: PdfPageFormat.a4,
                build: (format) => _generatePdf(
                  format.copyWith(
                    height: height * 0.74,
                    width: width,
                    marginLeft: margin,
                    marginRight: margin,
                    marginTop: marginTop,
                    marginBottom: marginBottom,
                  ),
                  title,
                  model,
                  height,
                ),
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
      viewModelBuilder: () {
        return PrintViewModel(deliveryNote, invoice);
      },
    );
  }

  _printDirect(PrintViewModel model) async {
    List<pw.Widget> widgets = [];
    // const width = 2.28346457 * PdfPageFormat.inch;
    double width = PdfPageFormat.roll57.availableWidth;
    const height = 300.0 * PdfPageFormat.mm;
    const marginLeft = 2 * PdfPageFormat.mm;
    const marginRight = 2 * PdfPageFormat.mm;
    const marginTop = 8 * PdfPageFormat.mm;
    const marginBottom = 10 * PdfPageFormat.mm;
    final font =
        await rootBundle.load("assets/fonts/proxima_nova/normal/proxima.ttf");
    final ttf = pw.Font.ttf(font);
    const imageProvider = const AssetImage('assets/images/mini_logo.png');
    final image = await flutterImageProvider(imageProvider);
    final pw.TextStyle style =
        pw.TextStyle.defaultStyle().copyWith(font: ttf, fontSize: 15);

    _buildWidgetTree() {
      List<pw.Widget> tree = [
        _buildPrintRef(model, style),
        _buildHeader(image, model, style),
        _buildSectionHeader("Section A: Sellers Detail", style),
        _buildSellersDetail(user, style, model),
        _buildSellersDetail(user, style, model),
        _buildSellersDetail(user, style, model),
        _buildSellersDetail(user, style, model),
        _buildSectionHeader("Section B: URA Information", style),
        _buildURAInformation(style, model),
        _buildSectionHeader("Section C: Buyers Details", style),
        _buildBuyerDetails(model, style),
        _buildSectionHeader("Section D: Goods and Services Details", style),
        ..._buildGoodsAndServices(items ?? deliveryNote.deliveryItems, style),
        _buildSpacer(),
        _buildSectionHeader("Section E: Tax Details", style),
        _buildTaxDetails(model, style),
        _buildSectionHeader("Section F: Summary",
            style.copyWith(fontWeight: pw.FontWeight.bold)),
        _buildSummary(model, style),
        _buildSpacer(),
        _buildFooter(model, style)
      ];
      widgets.addAll(tree);
    }

    _buildWidgetTree();

    final pdf = pw.Document(
      compress: true,
      title: model.invoice.id,
    );

    print(width);

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat(
        width * PdfPageFormat.mm,
        300 * PdfPageFormat.mm,
        // marginLeft: marginLeft,
        // marginRight: marginRight,
        marginTop: 5 * PdfPageFormat.mm,
        marginBottom: 10 * PdfPageFormat.mm,
      ),
      theme: pw.ThemeData(
          textAlign: pw.TextAlign.center,
          defaultTextStyle: pw.TextStyle(fontSize: 14, font: ttf)),
      build: (context) => widgets,
    ));

    Printing.layoutPdf(
      format: PdfPageFormat.roll57.copyWith(
          height: 130 * PdfPageFormat.cm,
          // width: 80 * PdfPageFormat.mm,
          marginTop: 5 * PdfPageFormat.mm,
          marginBottom: 10 * PdfPageFormat.mm),
      onLayout: (_) async => pdf.save(),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title,
      PrintViewModel model, double widgetHeight) async {
    final font =
        await rootBundle.load("assets/fonts/proxima_nova/normal/proxima.ttf");
    final ttf = pw.Font.ttf(font);
    const imageProvider = const AssetImage('assets/images/mini_logo.png');
    final image = await flutterImageProvider(imageProvider);
    const width = 2.28346457 * PdfPageFormat.inch;
    double height = widgetHeight * PdfPageFormat.mm;

    final pdf = pw.Document();
    final pw.TextStyle style = pw.TextStyle(font: ttf, fontSize: 14);

    pdf.addPage(pw.Page(
      pageFormat: format.copyWith(height: widgetHeight),
      build: (context) {
        return pw.Expanded(
            child: pw.Container(
                child: pw.Column(mainAxisSize: pw.MainAxisSize.min, children: [
          _buildPrintRef(model, style),
          _buildHeader(image, model, style),
          _buildSectionHeader("Section A: Sellers Detail", style),
          _buildSellersDetail(user, style, model),
          _buildSellersDetail(user, style, model),
          _buildSellersDetail(user, style, model),
          _buildSellersDetail(user, style, model),
          _buildSectionHeader("Section B: URA Information", style),
          _buildURAInformation(style, model),
          _buildSectionHeader("Section C: Buyers Details", style),
          _buildBuyerDetails(model, style),
          _buildSectionHeader("Section D: Goods and Services Details", style),
          ..._buildGoodsAndServices(items ?? deliveryNote.deliveryItems, style),
          _buildSpacer(),
          _buildSectionHeader("Section E: Tax Details", style),
          _buildTaxDetails(model, style),
          _buildSectionHeader("Section F: Summary",
              style.copyWith(fontWeight: pw.FontWeight.bold)),
          _buildSummary(model, style),
          _buildSpacer(),
          _buildFooter(model, style)
        ])));
      },
    ));
    return pdf.save();
  }

  ///
  /// Build the header of the invoice
  ///
  _buildHeader(
      pw.ImageProvider image, PrintViewModel model, pw.TextStyle style) {
    return pw.Row(children: [
      pw.Padding(
        child: pw.Container(
            child: pw.Image(image, height: 70), width: 100, height: 70),
        padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      ),
      // pw.Placeholder(fallbackHeight: 50, fallbackWidth: 50),
      pw.SizedBox(width: 20),
      pw.Column(children: [
        pw.Text(title,
            style:
                style.copyWith(fontSize: 18, fontWeight: pw.FontWeight.bold)),
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

  _buildBuyerDetails(PrintViewModel model, pw.TextStyle style) {
    return pw.Column(children: [
      pw.Row(children: [
        pw.Text('Customer Name :', style: style),
        pw.Text(deliveryNote.customerName ?? "", style: style)
      ]),
      // pw.Row(children: [
      //   pw.Text('Customer ID :', style: style),
      //   pw.Text(model.customerTIN ?? "", style: style)
      // ]),
      pw.Row(
        children: [
          pw.Text('Customer Address :', style: style),
          pw.Text("", style: style)
        ],
      ),
      pw.Row(children: [
        pw.Text('Customer TIN :', style: style),
        pw.Text("", style: style)
      ]),
    ]);
  }

  _buildGoodsAndServices(List deliveryItems, pw.TextStyle style) {
    return deliveryItems.map((deliveryItem) {
      num deliveredQty =
          deliveryItem['deliveredQty'] ?? deliveryItem['quantity'] ?? 0.0;
      num total = deliveredQty * deliveryItem['itemRate'];
      return pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: 2),
        child: pw.Column(children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              // pw.Text(deliveryItem['itemCode'], style: style),

              pw.Expanded(
                child: pw.Text(deliveryItem['itemName'], style: style),
              ),
              pw.Container(
                child: pw.Text(deliveredQty.toString(),
                    style: style, textAlign: pw.TextAlign.right),
              ),
              pw.Container(
                child:
                    pw.Text(" x ", style: style, textAlign: pw.TextAlign.right),
              ),
              pw.SizedBox(width: 5),
              pw.Text('${deliveryItem['itemRate']}'.toString(), style: style),
              pw.SizedBox(width: 5),
              _buildCurrencyWidget(total, style),
            ],
          )
        ]),
      );
    }).toList();
  }

  _buildSectionHeader(final String sectionHeader, pw.TextStyle style) {
    return pw.Column(children: [
      pw.Divider(),
      pw.Text(sectionHeader),
      pw.Divider(),
    ]);
  }

  _buildSellersDetail(User user, pw.TextStyle textStyle, PrintViewModel model) {
    var deliveryNoteId = deliveryNote.deliveryNoteId == null
        ? deliveryNote.referenceNo
        : orderId;
    return pw.Column(children: [
      // _buildSpacer(),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text("TIN", style: textStyle),
          pw.Text("1000219401", style: textStyle),
        ],
      ),
      pw.SizedBox(height: 5),
      pw.Text('MINI BAKERIES(UGANDA) LIMITED'.toUpperCase(), style: textStyle),
      pw.Text('4/5 Spring Road Nakawa'.toUpperCase(), style: textStyle),
      pw.Text('Kampala Nakawa Division'.toUpperCase(), style: textStyle),
      pw.Text('Nakawa Division Bugolobi'.toUpperCase(), style: textStyle),
      pw.Text(user.branch.toUpperCase(), style: textStyle),
      pw.Row(
        children: [
          pw.Text('Seller\'s Reference : ', style: textStyle),
          pw.Text(user.full_name, style: textStyle),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Served By : ', style: textStyle),
          pw.Text(user.full_name, style: textStyle),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Transaction Id : ', style: textStyle),
          pw.Text('${model.invoice.id}', style: textStyle),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Transaction Date : ', style: textStyle),
          pw.Text('${model.invoice.transactionDate}', style: textStyle),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Type : ', style: textStyle),
          pw.Text('${model.invoice.transactionType}', style: textStyle),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Transaction Status : ', style: textStyle),
          pw.Text('${model.invoice.transactionStatus}', style: textStyle),
        ],
      ),
    ]);
  }

  _buildSpacer() {
    return pw.SizedBox(height: 20);
  }

  _buildFooter(PrintViewModel model, pw.TextStyle style) {
    return pw.Column(children: [
      _buildSpacer(),
      pw.Center(
        child: pw.Text(model.deviceId, style: style),
      ),
      pw.SizedBox(height: 2),
      pw.Text("Powered by DDS ver:${model.versionCode}", style: style)
    ], crossAxisAlignment: pw.CrossAxisAlignment.center);
  }

  _buildSummary(PrintViewModel model, pw.TextStyle style) {
    return pw.Column(children: [
      pw.SizedBox(height: 5),
      pw.Row(children: [
        pw.Text('Net Amount', style: style),
        _buildCurrencyWidget(model.invoice.net, style),
      ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween),
      pw.Row(children: [
        pw.Text('Tax Amount', style: style),
        _buildCurrencyWidget(model.invoice.tax, style),
      ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween),
      pw.Row(children: [
        pw.Text('Gross Amount', style: style),
        _buildCurrencyWidget(model.invoice.gross, style),
      ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween),
    ]);
  }

  _buildTaxDetails(PrintViewModel model, pw.TextStyle style) {
    return pw.Column(children: [
      pw.SizedBox(height: 5),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Text('Tax Category : ', style: style),
          pw.Text('A: Standard (${(model.taxRate * 100).toStringAsFixed(0)}%)'),
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
          _buildCurrencyWidget(model.invoice.net, style),
          _buildCurrencyWidget(model.invoice.tax, style),
          _buildCurrencyWidget(model.invoice.gross, style),
        ],
      ),
    ]);
  }

  _buildCurrencyWidget(num val, pw.TextStyle style, {String currency = "UGX"}) {
    return pw.Text('${currency} ${Helper.formatCurrency(val)}', style: style);
  }

  ///
  /// Build printer information
  /// Build version info
  ///
  _buildPrintRef(PrintViewModel model, pw.TextStyle style) {
    return pw.Row(children: [
      pw.Text("${model.versionCode}-${model.deviceId}"),
    ], mainAxisAlignment: pw.MainAxisAlignment.end);
  }

  _buildURAInformation(pw.TextStyle style, PrintViewModel model) {
    return pw.Column(children: [
      pw.Row(
        children: [
          pw.Text('Document Type : ${model.documentType}', style: style),
        ],
      ),
      pw.Row(
        children: [
          pw.Text(
              'Issued Date : ${Helper.formatDateFromString(model.invoice.transactionDate)} ',
              style: style),
        ],
      ),
      pw.Row(
        children: [
          pw.Text(
              'Time : ${Helper.formatTimeFromString(model.invoice.transactionDate)} ',
              style: style),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Device No: ${model.invoice.deviceNo}', style: style),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('FDN: ${model.FDN}', style: style),
        ],
      ),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Text('Verification Code: ${model.verificationCode}', style: style),
        ],
      ),
    ]);
  }
}
