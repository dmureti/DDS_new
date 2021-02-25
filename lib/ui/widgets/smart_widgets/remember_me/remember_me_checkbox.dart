import 'package:distributor/ui/widgets/smart_widgets/remember_me/remember_me_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RememberMeCheckbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RememberMeViewModel>.reactive(
      viewModelBuilder: () => RememberMeViewModel(),
      builder: (context, model, child) => Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            onChanged: (val) async {
              await model.toggleSavePassword(val);
            },
            value: model.rememberMe,
          ),
          Text(
            'Remember me',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
          ),
        ],
      ),
    );
  }
}
