import 'package:flutter/material.dart';

typedef Null ItemSelectedCallback(int value);

class ListWidget extends StatefulWidget {
  ///How many items to display
  final List items;

  /// Callback when an item is clicked
  /// Decides whether to simply change the detail view on large screen
  /// Or Navigate to another page
  final ItemSelectedCallback onItemSelected;
  const ListWidget({Key key, this.items, this.onItemSelected})
      : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, position) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
