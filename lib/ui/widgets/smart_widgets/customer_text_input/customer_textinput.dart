import 'package:distributor/conf/style/lib/fonts.dart';
import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CustomerTextInput extends StatefulWidget {
  final List<Customer> customerList;
  final Function onSelected;
  const CustomerTextInput(
      {Key key, @required this.customerList, @required this.onSelected})
      : super(key: key);

  @override
  State<CustomerTextInput> createState() => _CustomerTextInputState();
}

class _CustomerTextInputState extends State<CustomerTextInput> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<Customer>(
      displayStringForOption: (customer) => customer.name,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Customer>.empty();
        }
        return widget.customerList.where((Customer customer) {
          return customer.name
              .toLowerCase()
              .startsWith(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (Customer customer) {
        FocusScope.of(context).unfocus();
        widget.onSelected(customer);
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) {
            fieldTextEditingController.text = "";
          },
          onEditingComplete: () {
            // Focus.of(context).unfocus();
            print('done');
            //Close the keyboard
            fieldFocusNode.unfocus();
          },
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search_sharp),
            hintText: 'Search',
            hintStyle: TextStyle(fontFamily: kFontThinBody),
            suffixIcon: IconButton(
              onPressed: () {
                fieldTextEditingController.text = "";
              },
              icon: Icon(Icons.close_sharp),
            ),
          ),
        );
      },
    );
  }
}
