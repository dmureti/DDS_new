import 'package:distributor/core/enums.dart';
import 'package:distributor/ui/widgets/smart_widgets/buttons/customer/customer_button_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CustomerButton extends StatelessWidget {
  final Function onTap;
  final Function onUpdateIndex;
  const CustomerButton({Key key, this.onTap, this.onUpdateIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerButtonViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => model.isBusy
            ? CircularProgressIndicator()
            : IconButton(
                icon: Icon(Icons.people),
                disabledColor: Colors.white.withOpacity(0.4),
                onPressed: () {
                  print(model.isEnabled);
                  if (model.isEnabled) {
                    // User has permission
                    onUpdateIndex(3);
                    onTap(Pages.customers, 'Customers');
                  } else {
                    //User has no permission
                    null;
                  }
                },
              ),
        viewModelBuilder: () => CustomerButtonViewModel());
  }
}
