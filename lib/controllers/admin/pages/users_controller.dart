import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/network/api.dart';

class AdminUsersController extends GetxController {
  //scroll controller
  var scrollController = ScrollController();

  final Api api = Get.find<Api>();
  var currentPage = 1.obs;
  var stillLoading = true.obs;

  var users = [].obs;

  @override
  void onInit() {
    scrollController.addListener(__scrollListener);

    super.onInit();
  }

  Future<void> get() async {
    stillLoading.value = true;

    if (currentPage.value == 1) {
      users.clear();
    }
    var result = await api.getUsers(10, currentPage.value);

    result = jsonDecode(result.body);
    if (result['status'] == 200) {
      for (var item in result['data']['users']) {
        users.add(item);
        stillLoading.value = false;
      }
    } else if (result['status'] == 404) {
      stillLoading.value = false;
    } else {
      Get.snackbar('Error', result['message']);
    }
  }

  void __scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print('get more data');
      currentPage.value++;
      get();
    }
  }
}
