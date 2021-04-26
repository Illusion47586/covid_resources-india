import 'package:connectivity/connectivity.dart';
import 'package:covid_resources/main.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../core/services/data_service.dart';
import '../screens/main_screen.dart';
import 'state_search_controller.dart';

class CitySearchController extends GetxController {
  int stateIndex = Get.find<StateSearchController>().selectedIndex;

  @override
  void onReady() {
    stateIndex = prefs.getInt('stateIndex');
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
    await Get.find<DataService>().writeIndices(stateIndex, index);
    Get.find<StateSearchController>().doneSelecting();
  }
}
