import 'package:distributor/ui/widgets/smart_widgets/qr_widget/qr_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stacked/stacked.dart';

class QRWidget extends StatelessWidget {
  final String data;
  final double size;
  const QRWidget({Key key, this.data, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => QRWidgetViewModel(),
      builder: (context, model, view) {
        return QrImage(
          data: data,
        );
      },
    );
  }
}
