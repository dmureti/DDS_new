import 'package:distributor/ui/widgets/fragments/detail_widget.dart';
import 'package:distributor/ui/widgets/fragments/list_widget.dart';
import 'package:flutter/material.dart';

class MasterDetailPage extends StatefulWidget {
  const MasterDetailPage({Key key}) : super(key: key);

  @override
  _MasterDetailPageState createState() => _MasterDetailPageState();
}

class _MasterDetailPageState extends State<MasterDetailPage> {
  ///Store the seleted item
  var selectedValue = 0;

  /// Store if the screen is large enough to display detail and list
  var isLargeScreen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      ///Use Orientation builder in case screen is oriented in a way that can display
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (MediaQuery.of(context).size.width > 600) {
            isLargeScreen = true;
          } else {
            isLargeScreen = false;
          }
          return Row(
            children: [
              Expanded(
                child: ListWidget(
                    count: 10,
                    onItemSelected: (value) {
                      if (isLargeScreen) {
                        selectedValue = value;
                        setState(() {});
                      } else {}
                    }),
              ),
              isLargeScreen
                  ? Expanded(child: DetailWidget(data: selectedValue))
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
