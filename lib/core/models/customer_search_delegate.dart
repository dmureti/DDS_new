import 'package:flutter/material.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CustomerSearchDelegate extends SearchDelegate {
  final List<Customer> customerList;
  final onTap;

  CustomerSearchDelegate({this.customerList, this.onTap});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListTile(
      title: Text(selectedCustomer.name),
      onTap: () => onTap(selectedCustomer),
    );
  }

  Customer selectedCustomer;
  @override
  Widget buildSuggestions(BuildContext context) {
    List myCustomer = query.isEmpty
        ? customerList
        : customerList
            .where((customer) =>
                customer.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
        itemCount: myCustomer.length,
        itemBuilder: (context, index) {
          Customer customer = myCustomer[index];
          return ListTile(
            title: Text(customer.name),
            onTap: () {
              showResults(context);
              selectedCustomer = customer;
            },
          );
        });
  }
}
