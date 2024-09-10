import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/src/ui/views/reset_password/reset_password_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
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
                  Text(
                    'Forgotten your password ? Please enter your phone number or email address. You shall receive a reset password.',
                    style: kLeadingBodyText,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  _UserIdTextFormField(),
                  SizedBox(
                    height: 16,
                  ),
                  model.isBusy
                      ? BusyWidget()
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed:
                                model.userId != null && model.userId.isNotEmpty
                                    ? model.resetPassword
                                    : null,
                            child: Text(
                              'Reset Password',
                              // style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => ResetPasswordViewmodel());
  }
}

class _UserIdTextFormField extends HookViewModelWidget<ResetPasswordViewmodel> {
  @override
  Widget buildViewModelWidget(
      BuildContext context, ResetPasswordViewmodel model) {
    var _controller = useTextEditingController();
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          filled: false,
          hintText: 'Email Address OR Phone Number'),
      onChanged: (val) => model.setUserId(val),
      controller: _controller,
    );
  }
}
