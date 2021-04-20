import 'package:distributor/src/ui/views/reset_password/reset_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ResetPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPasswordViewmodel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            body: Container(
              child: Text(
                  'Your account is not activated. Please log in to Web Application to activate it or contact the System Administrator'),
            ),
          );
        },
        viewModelBuilder: () => ResetPasswordViewmodel());
  }
}
