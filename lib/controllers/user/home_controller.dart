import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  var selectedIndex = 1.obs;
  var pageController;


  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

}
