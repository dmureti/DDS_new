import 'package:distributor/src/ui/views/change_password/change_password_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class ChangePasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
        onModelReady: (model) => model.init(),
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
                      'If it is the first time to use this application, use the password you received via email or sms as the old password'),
                  _oldPassTextFormField(),
                  SizedBox(
                    height: 4,
                  ),
                  _newPassTextFormField(),
                  SizedBox(
                    height: 4,
                  ),
                  _confirmPassTextFormField(),
                  SizedBox(
                    height: 8,
                  ),
                  model.isBusy
                      ? BusyWidget()
                      : RaisedButton(
                          onPressed:
                              model.enableSubmit ? model.changePassword : null,
                          child: Text('Change Password'),
                        )
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => ChangePasswordViewModel());
  }
}

class _oldPassTextFormField
    extends HookViewModelWidget<ChangePasswordViewModel> {
  @override
  Widget buildViewModelWidget(
      BuildContext context, ChangePasswordViewModel model) {
    var _controller = useTextEditingController();
    return TextFormField(
      onChanged: (val) => model.setOldPassword(val),
      controller: _controller,
      decoration: InputDecoration(labelText: 'Old password'),
    );
  }
}

class _newPassTextFormField
    extends HookViewModelWidget<ChangePasswordViewModel> {
  @override
  Widget buildViewModelWidget(
      BuildContext context, ChangePasswordViewModel model) {
    var _controller = useTextEditingController();
    return TextFormField(
      onChanged: (val) => model.setNewPassword(val),
      controller: _controller,
      decoration: InputDecoration(labelText: 'New password'),
    );
  }
}

class _confirmPassTextFormField
    extends HookViewModelWidget<ChangePasswordViewModel> {
  @override
  Widget buildViewModelWidget(
      BuildContext context, ChangePasswordViewModel model) {
    var _controller = useTextEditingController();
    return TextFormField(
      onChanged: (val) => model.setConfirmPassword(val),
      controller: _controller,
      decoration: InputDecoration(labelText: 'Confirm password'),
    );
  }
}
