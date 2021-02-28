import 'package:distributor/core/enums.dart';
import 'package:distributor/ui/access_controllers/global/bottom_navbar/bottom_navbar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ButtonBarIconButton extends StatelessWidget {
  final Function onTap;
  final Function updateIndex;
  final String title;
  final int index;
  final bool isEnabled;
  final Pages page;
  final IconData iconData;
  const ButtonBarIconButton(
      {Key key,
      this.onTap,
      this.iconData,
      this.index,
      this.title,
      this.updateIndex,
      this.isEnabled,
      this.page})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavBarViewModel>.reactive(
      viewModelBuilder: () => BottomNavBarViewModel(onTap, index),
      builder: (context, model, child) => IconButton(
        splashColor: Colors.pink,
        icon: Icon(
          iconData,
          color: isEnabled ? Colors.white : Colors.white.withOpacity(0.3),
        ),
        onPressed: () {
          if (isEnabled) {
            updateIndex(index);
            onTap(page, title);
          }
        },
      ),
    );
  }
}
