import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/router.dart';
import 'core/services/initial_binding.dart';
import 'core/theme/theme.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid India Resources',
      initialBinding: InitialBinding(),
      theme: ThemeHandler.themeData,
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
      initialRoute: RouteHandler.initialRoute,
      unknownRoute: RouteHandler.unknownRoute,
      getPages: RouteHandler.routes,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          ),
        );
      },
      enableLog: true,
      logWriterCallback: localLogWriter,
    );
  }
}

void localLogWriter(String text, {bool isError = false}) {
  if (isError)
    Logger().e(text);
  else
    Logger().v(text);
}
