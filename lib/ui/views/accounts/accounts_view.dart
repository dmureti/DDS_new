import 'package:distributor/ui/views/accounts/accounts_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AccountsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountsViewModel>.reactive(
        builder: (context, model, child) => Container(),
        viewModelBuilder: () => AccountsViewModel());
  }
}
