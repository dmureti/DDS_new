import 'package:flutter/material.dart';

class AppBarSearch<T> extends StatelessWidget {
  final SearchDelegate<T> delegate;

  const AppBarSearch({@required this.delegate, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(
        Icons.search,
        color: Colors.white,
      ),
      label: Text(
        'Search',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        showSearch(context: context, delegate: delegate);
      },
    );
  }
}
