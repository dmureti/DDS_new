import 'package:flutter/material.dart';

typedef Null ItemSelectedCallback(int value);

class ListWidget extends StatefulWidget {
  ///How many items to display
  final int count;

  /// Callback when an item is clicked
  /// Decides whether to simply change the detail view on large screen
  /// Or Navigate to another page
  final ItemSelectedCallback onItemSelected;
  const ListWidget({Key key, this.count, this.onItemSelected})
      : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.count,
        itemBuilder: (context, position) {
          return Padding(
            child: Card(
              child: InkWell(
                onTap: () {
                  widget.onItemSelected(position);
                },
                child: Row(
                  children: [],
                ),
              ),
            ),
          );
        });
  }
}
