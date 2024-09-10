import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

class SKUAutoComplete extends StatefulWidget {
  final List<Product> productList;
  final Function onSelected;

  SKUAutoComplete({Key key, this.onSelected, this.productList})
      : super(key: key);

  @override
  State<SKUAutoComplete> createState() => _SKUAutoCompleteState();
}

class _SKUAutoCompleteState extends State<SKUAutoComplete> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<Product>.empty();
        }
        return widget.productList
            .where((Product p) => p.itemName
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()))
            .toList();
      },
      onSelected: (Product product) {},
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (_) {
            fieldTextEditingController.text = "";
          },
          onEditingComplete: () {
            fieldFocusNode.unfocus();
          },
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search for an SKU',
              suffixIcon: IconButton(
                  onPressed: null, icon: Icon(Icons.cancel_outlined))),
        );
      },
    );
  }
}
