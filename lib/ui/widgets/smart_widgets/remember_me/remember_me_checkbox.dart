import 'package:distributor/conf/dds_brand_guide.dart';
import 'package:distributor/ui/views/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class RememberMeCheckbox extends HookViewModelWidget<LoginViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, LoginViewModel model) {
    return Row(
      children: [
        Checkbox(
          activeColor: kColDDSPrimaryDark,
          checkColor: Colors.white,
          onChanged: (val) async {
            model.toggleSavePassword(val);
          },
          value: model.rememberMe,
        ),
        Text(
          'Remember me',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        ),
      ],
    );
  }
}
