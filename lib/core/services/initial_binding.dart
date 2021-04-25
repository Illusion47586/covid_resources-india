import 'package:get/get.dart';

import 'data_service.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataService());
  }
}
