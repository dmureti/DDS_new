import 'package:distributor/ui/views/app_info/app_info_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppInfoView extends StatelessWidget {
  const AppInfoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppInfoViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('About'),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Image.asset(
                        'assets/images/dds_logo.png',
                      ),
                    ),
                  ),
                  Text('Version : ${model.version}')
                ],
              ),
            ),
        viewModelBuilder: () => AppInfoViewModel());
  }
}
