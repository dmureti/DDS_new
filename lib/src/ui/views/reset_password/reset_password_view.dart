import 'package:distributor/src/ui/views/reset_password/reset_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class ResetPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPasswordViewmodel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Password Reset'),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  RaisedButton(
                    onPressed: model.resetPassword,
                    child: Text('Reset Password'),
                  )
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => ResetPasswordViewmodel());
  }
}
