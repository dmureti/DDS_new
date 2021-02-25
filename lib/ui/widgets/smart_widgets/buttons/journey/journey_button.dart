import 'package:distributor/core/enums.dart';
import 'package:distributor/ui/widgets/smart_widgets/buttons/journey/journey_button_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class JourneyButton extends StatelessWidget {
  final Function onTap;
  final Function onUpdateIndex;
  const JourneyButton({Key key, this.onTap, this.onUpdateIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneyButtonViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => model.isBusy
            ? CircularProgressIndicator()
            : IconButton(
                icon: Icon(Icons.home),
                disabledColor: Colors.white.withOpacity(0.4),
                onPressed: () {
//                print(model.isEnabled);
                  if (model.isEnabled) {
                    // User has permission
                    onUpdateIndex(0);
                    onTap(Pages.home, 'Home');
                  } else {
                    //User has no permission
                    null;
                  }
                },
              ),
        viewModelBuilder: () => JourneyButtonViewModel());
  }
}
