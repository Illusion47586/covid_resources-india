import 'package:get/get_navigation/get_navigation.dart';

import '../main.dart';
import '../views/screens/city_search_screen.dart';
import '../views/screens/main_screen.dart';
import '../views/screens/state_search_screen.dart';

class RouteHandler {
  static String initialRoute =
      (prefs.getInt('cityIndex') == null) || (prefs.getInt('cityIndex') == -1)
          ? StateSearchScreen.id
          : MainScreen.id;

  static GetPage unknownRoute = GetPage(
    name: StateSearchScreen.id,
    page: () => StateSearchScreen(),
  );

  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: MainScreen.id,
      page: () => MainScreen(),
    ),
    GetPage(
      name: StateSearchScreen.id,
      page: () => StateSearchScreen(),
    ),
    GetPage(
      name: CitySearchScreen.id,
      page: () => CitySearchScreen(),
    ),
  ];
}
