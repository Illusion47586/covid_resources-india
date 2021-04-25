import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import 'core/router.dart';
import 'core/theme/theme.dart';
import 'core/services/initial_binding.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

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
