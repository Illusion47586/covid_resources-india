import 'package:covid_resources/views/screens/main_screen.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

import '../views/screens/city_search_screen.dart';
import '../views/screens/state_search_screen.dart';

class RouteHandler {
  static String initialRoute = GetStorage().read('cityIndex') == null
      ? StateSearchScreen.id
      : MainScreen.id;

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
