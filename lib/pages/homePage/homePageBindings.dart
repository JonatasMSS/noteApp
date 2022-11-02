import 'package:get/get.dart';

import 'package:notesapp/pages/homePage/homePageController.dart';
import 'package:sqflite/sqflite.dart';

class HomePageBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomePageController());
  }
}
