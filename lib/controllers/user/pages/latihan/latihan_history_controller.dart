import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymapp/controllers/user/pages/dashboard_controller.dart';
import 'package:gymapp/network/api.dart';

class LatihanHistoryController extends GetxController {
  final RxInt isCheckIn = 0.obs;
  DashboardController dashboardController = Get.find<DashboardController>();
  var isSubscribed = 0.obs;
  RxInt currentPage = 1.obs;
  final Api api = Get.put(Api());
  final scrollController = ScrollController();
  var box = GetStorage();
  var isLoading = false.obs;
  var isMoreDataAvailable = true.obs;

  final history = RxList([
    // Add your initial history items here
  ]).obs;

  @override
  void onInit() {
    scrollController.addListener(__scrollListener);

    super.onInit();
  }

  void __scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      
      currentPage.value++;
      await getLatihan();
    }
  }

  Future<void> getLatihan() async {
    isLoading.value = true;
    if (currentPage.value == 1) {
      history.value = RxList([
        // Add your initial history items here
      ]);
    }
    var result = await api.getLatihan(40, currentPage.value);
    var decodedData = jsonDecode(result.body);

    // Parse dateTime and add to history list
    for (var item in decodedData['data']['latihan']) {
      try {
        var dateTimeString = item['dateTime'] as String?;
        var isCheckin = item['isCheckin'] as String?;

        if (dateTimeString != null && isCheckin != null) {
          var dateTime = DateTime.parse(dateTimeString);
          var date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
          var time = "${dateTime.hour}:${dateTime.minute}";

          if (isCheckin == "1") {
            history.value
                .add({"date": date, "time": time, "status": "checkin"});
          } else {
            history.value
                .add({"date": date, "time": time, "status": "checkout"});
          }
        }
        isLoading.value = false;
      } catch (e) {
        
        // Handle parsing errors here
      }
    }
    if (decodedData['data']['latihan'].length > 0) {
      isMoreDataAvailable.value = true;
      if (decodedData['data']['latihan'].length <40 ) {

      isMoreDataAvailable.value = false;
    }
    } 
    else{
      isMoreDataAvailable.value = false;
    }
  }
}
