import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/models/data_model.dart';
import '../../core/services/data_service.dart';

class MainController extends GetxController {
  Rx<int> selectedIndex = 0.obs;
  final PageController pageController = PageController();
  final DataService dataService = Get.find();
  final Map<Issue, Stream<List<DataModel>>> dataStream =
      Map<Issue, Stream<List<DataModel>>>();

  @override
  Future<void> onInit() async {
    for (var i in Issue.values) {
      dataStream[i] = dataService.dataStream[i].stream;
      await dataService.requestData(i);
    }
    super.onInit();
  }

  Future<void> updateIndex(int index) async {
    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    update();
    if (index < Issue.values.length)
      await dataService.requestData(Issue.values[selectedIndex.value]);
  }
}
