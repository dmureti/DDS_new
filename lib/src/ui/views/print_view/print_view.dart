import 'dart:typed_data';

import 'package:distributor/src/ui/views/print_view/print_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class PrintView extends StatelessWidget {
  final String title;
  final User user;
  final DeliveryNote deliveryNote;
  const PrintView({Key key, this.title, @required this.deliveryNote, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PrintViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text(title)),
          body: PdfPreview(
            build: (format) => _generatePdf(format, title),
          ),
        );
      },
      viewModelBuilder: () {
        return PrintViewModel(deliveryNote);
      },
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    const imageProvider = const AssetImage('assets/images/mini_logo.png');
    final image = await flutterImageProvider(imageProvider);
    final pdf = pw.Document(compress: true);
    // final font = await PdfGoogleFonts.nunitoExtraLight();
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              _buildHeader(image),
              _buildSectionHeader("Section A: Sellers Detail"),
              _buildSellersDetail(user),
              _buildSectionHeader("Section B: URA Information"),
              _buildSectionHeader("Section C: Buyers Details"),
              _buildBuyerDetails(),
              _buildSectionHeader("Section D: Goods and Services Details"),
              ..._buildGoodsAndServices(deliveryNote.deliveryItems),
              _buildSectionHeader("Section E: Tax Details"),
              _buildTaxDetails(),
              _buildSectionHeader("Section F: Summary"),
              _buildSummary(),
              // _buildFooter(model),
              // pw.SizedBox(
              //   width: double.infinity,
              //   child: pw.FittedBox(
              //     child: pw.Text(title),
              //   ),
              // ),
              // pw.SizedBox(height: 20),
              // pw.Flexible(child: pw.FlutterLogo())
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  _buildHeader(pw.ImageProvider image) {
    return pw.Row(children: [
      pw.Container(child: pw.Image(image, height: 50), width: 50, height: 50),
      // pw.Placeholder(fallbackHeight: 50, fallbackWidth: 50),
      pw.SizedBox(width: 10),
      pw.Text(title, style: pw.TextStyle(fontSize: 20)),
      //DDS Logo
      //Title
    ]);
  }

  _printQRCode() {}

  _buildBuyerDetails() {
    return pw.Row(children: [
      pw.Text('Customer Name :', style: pw.TextStyle(fontSize: 15)),
      pw.Text(deliveryNote.customerName ?? "",
          style: pw.TextStyle(fontSize: 15))
    ]);
  }

  _buildGoodsAndServices(List deliveryItems) {
    final pw.TextStyle style = pw.TextStyle(fontSize: 15);
    return deliveryItems
        .map(
          (deliveryItem) => pw.Padding(
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
                    child: pw.Text(deliveryItem['quantity'].toString(),
                        style: style, textAlign: pw.TextAlign.right),
                  ),
                  pw.SizedBox(width: 5),
                  pw.Text('${deliveryItem['itemRate']}'.toString(),
                      style: style),
                  pw.SizedBox(width: 5),
                  pw.Text(
                      'UGX ${deliveryItem['itemRate'] * deliveryItem['quantity']}'
                          .toString(),
                      style: style),
                ],
              )
            ]),
          ),
        )
        .toList();
  }

  _buildSectionHeader(final String sectionHeader) {
    return pw.Column(children: [
      pw.Divider(),
      pw.Text(sectionHeader, style: pw.TextStyle(fontSize: 16)),
      pw.Divider(),
    ]);
  }

  _buildSellersDetail(User user) {
    final pw.TextStyle textStyle = pw.TextStyle(fontSize: 20);
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
      pw.SizedBox(height: 10),
      pw.Row(
        children: [
          pw.Text('Seller\'s Reference No : ',
              style: pw.TextStyle(fontSize: 15)),
          pw.Text(user.full_name, style: pw.TextStyle(fontSize: 15)),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Served By : ', style: pw.TextStyle(fontSize: 15)),
          pw.Text(user.full_name, style: pw.TextStyle(fontSize: 15)),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Invoice Id : ', style: pw.TextStyle(fontSize: 15)),
          pw.Text('${deliveryNote.deliveryNoteId}',
              style: pw.TextStyle(fontSize: 15)),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Delivery Date : ', style: pw.TextStyle(fontSize: 15)),
          pw.Text('${deliveryNote.deliveryDate}',
              style: pw.TextStyle(fontSize: 15)),
        ],
      ),
      pw.Row(
        children: [
          pw.Text('Delivery Status : ', style: pw.TextStyle(fontSize: 15)),
          pw.Text('${deliveryNote.deliveryStatus}',
              style: pw.TextStyle(fontSize: 15)),
        ],
      ),
      _buildSpacer(),
    ]);
  }

  _buildSpacer() {
    return pw.SizedBox(height: 20);
  }

  _buildFooter(model) {
    return pw.Text(model.androidDeviceInfo.androidId);
  }

  _buildSummary() {
    return pw.Column(children: [
      pw.SizedBox(height: 5),
      pw.Row(children: [
        pw.Text('Net Amount', style: pw.TextStyle(fontSize: 15)),
        pw.Text('', style: pw.TextStyle(fontSize: 15))
      ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween),
      pw.Row(children: [
        pw.Text('Tax Amount', style: pw.TextStyle(fontSize: 15)),
        pw.Text('', style: pw.TextStyle(fontSize: 15)),
      ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween),
      pw.Row(children: [
        pw.Text('Gross Amount', style: pw.TextStyle(fontSize: 15)),
        pw.Text('', style: pw.TextStyle(fontSize: 15))
      ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween),
    ]);
  }

  _buildTaxDetails() {
    final pw.TextStyle style = pw.TextStyle(fontSize: 15);
    return pw.Column(children: [
      pw.SizedBox(height: 5),
      pw.Text('Tax Category', style: style),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Net Amt', style: style),
          pw.Text('Tax Amt', style: style),
          pw.Text('Gross Amt', style: style),
        ],
      ),
      pw.Text('A: Standard (18%)'),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('', style: style),
          pw.Text('', style: style),
          pw.Text('', style: style),
        ],
      ),
    ]);
  }
}
