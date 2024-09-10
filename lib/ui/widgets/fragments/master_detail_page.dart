import 'package:distributor/ui/widgets/fragments/detail_widget.dart';
import 'package:distributor/ui/widgets/fragments/list_widget.dart';
import 'package:flutter/material.dart';

class MasterDetailPage extends StatefulWidget {
  final List items;
  const MasterDetailPage({Key key, @required this.items}) : super(key: key);

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
    return OrientationBuilder(
      builder: (context, orientation) {
        if (MediaQuery.of(context).size.width > 600) {
          isLargeScreen = true;
        } else {
          isLargeScreen = false;
        }
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: ListWidget(
                  items: widget.items,
                  onItemSelected: (value) {
                    if (isLargeScreen) {
                      selectedValue = value;
                      setState(() {});
                    } else {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DetailWidget(data: value);
                        },
                      ));
                    }
                  }),
            ),
            isLargeScreen
                ? Expanded(flex: 4, child: DetailWidget(data: selectedValue))
                : Container(),
          ],
        );
      },
    );
  }
}
