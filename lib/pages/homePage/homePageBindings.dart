import 'package:get/get.dart';
import 'package:notesapp/pages/homePage/homePageController.dart';

class HomePageBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomePageController());
  }
}
