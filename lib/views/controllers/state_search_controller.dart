import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../main.dart';
import '../screens/main_screen.dart';

class StateSearchController extends GetxController {
  @override
  void onReady() {
    searchBarController.open();
    super.onReady();
  }

  final FloatingSearchBarController searchBarController =
      FloatingSearchBarController();

  final Stream connectionStream = Connectivity().onConnectivityChanged;

  bool failCondition(dynamic data) => data != ConnectivityResult.none;

  int selectedIndex;

  Future<void> updateIndex(int index) async {
    selectedIndex = index;
    await prefs.setInt('stateIndex', index);
  }

  void doneSelecting() {
    navigator.pop();
    navigator.pushReplacementNamed(MainScreen.id);
  }
}
