import 'package:distributor/ui/widgets/smart_widgets/environment_selection_dropdown/environment_selection_dropdown_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class EnvironmentSelectionDropDown extends StatelessWidget {
  EnvironmentSelectionDropDown();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EnvironmentSelectionDropDownViewModel>.reactive(
      viewModelBuilder: () => EnvironmentSelectionDropDownViewModel(),
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DropdownButton(
          underline: Container(
            height: 2,
            color: Colors.black,
          ),
          dropdownColor: Colors.white,
          icon: Icon(
            AntDesign.caretdown,
            size: 15,
          ),
          onChanged: (AppEnv appEnv) {
            model.updateEnv(appEnv);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                  child: Text('Using ${model.appEnv.name}'),
                ),
              ),
            );
          },
          value: model.appEnv,
          hint: Text('Select Environment'),
          items: model.availableEnvList
              .map((AppEnv appEnv) => DropdownMenuItem(
                    value: appEnv,
                    child: Text(
                      '${appEnv.name}',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Colors.black54),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
