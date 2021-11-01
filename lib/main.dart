import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/enums.dart';
import 'package:distributor/services/connectivity_service.dart';
import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/app/router.gr.dart' as app_router;

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      create: (context) =>
          ConnectivityService().connectionStatusController.stream,
      child: MaterialApp(
        supportedLocales: const [Locale('en'), Locale('en_us')],
        title: Globals.appName,
        debugShowCheckedModeBanner: false,
        theme: _kAppTheme,
        initialRoute: Routes.startupView,
        onGenerateRoute: app_router.Router().onGenerateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      ),
    );
  }
}

final ThemeData _kAppTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: kColorMiniDarkBlue,
    // canvasColor: kCanvasColor,
    dialogTheme: DialogTheme(
        titleTextStyle:
            TextStyle(fontWeight: FontWeight.w700, color: Colors.indigo)),
    appBarTheme: AppBarTheme(
      elevation: 1.0,
      color: Color(0xFF303891),
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kColorMiniDarkBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(10.0),
      focusColor: Colors.grey,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: kColorMiniDarkBlue, style: BorderStyle.solid, width: 2),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Colors.green, style: BorderStyle.solid, width: 2.0),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      filled: false,
    ),
    textTheme: _buildAppTextTheme(base.textTheme),
    primaryTextTheme: _buildAppTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildAppTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildAppTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5.copyWith(
          color: Colors.pink,
          fontFamily: 'ProximaNova700',
        ),
        headline6: base.headline6.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontFamily: 'ProximaNova500',
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1.copyWith(
            fontFamily: 'ProximaNovaRegular',
            fontSize: 14.0,
            color: Colors.white),
        button: base.button.copyWith(color: Colors.pink),
        bodyText2: base.bodyText1.copyWith(
            fontFamily: 'ProximaNovaRegular',
            fontSize: 14.0,
            color: Colors.white),
      )
      .apply(
        fontFamily: 'ProximaNovaRegular',
        displayColor: Colors.grey,
        bodyColor: Colors.black,
      );
}
