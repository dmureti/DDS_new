import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/app/router.gr.dart' as app_router;

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [Locale('en'), Locale('en_us')],
      title: Globals.appName,
      debugShowCheckedModeBanner: false,
      theme: _kAppTheme,
      initialRoute: Routes.startupView,
      onGenerateRoute: app_router.Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}

final ThemeData _kAppTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: kDarkBlue,
    accentColor: Colors.pink,
    canvasColor: kCanvasColor,
    dialogTheme: DialogTheme(
        titleTextStyle:
            TextStyle(fontWeight: FontWeight.w900, color: Colors.indigo)),
    appBarTheme: AppBarTheme(
        elevation: 1.0,
        color: kDarkBlue,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
        iconTheme: IconThemeData(color: Colors.white)),
    buttonColor: Colors.pink,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: Colors.pink,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(10.0),
      focusColor: Colors.grey,
      focusedBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: kDarkBlue, style: BorderStyle.solid, width: 2),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Colors.green, style: BorderStyle.solid, width: 2.0),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      filled: true,
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
          fontWeight: FontWeight.w600,
          fontFamily: 'Simpel',
          fontSize: 18.0,
        ),
        headline6: base.headline6.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1.copyWith(
            fontWeight: FontWeight.w400, fontSize: 14.0, color: Colors.white),
        button: base.button.copyWith(color: Colors.pink),
        bodyText2: base.bodyText1.copyWith(
            fontWeight: FontWeight.w500, fontSize: 14.0, color: Colors.white),
      )
      .apply(
        fontFamily: 'Proxima Nova',
        displayColor: Colors.grey,
        bodyColor: Colors.black,
      );
}
