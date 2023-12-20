import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:gymapp/network/api.dart';

class AdminlatihanController extends GetxController {

  RxInt currentPage = 1.obs;
  final Api api = Get.put(Api());
  final scrollController = ScrollController();
  var box = GetStorage();
  var isLoading = false.obs;
  var stillMoreData = true.obs;

  final history = RxList([
    // Add your initial history items here
  ]).obs;

  @override
  void onInit() {

    scrollController.addListener(__scrollListener);

    super.onInit();
  }

  void __scrollListener()async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
          if(!stillMoreData.value) return;
          print('get more data');
      currentPage.value++;
      await getLatihan();
    }
  }

  Future<void> getLatihan() async {

    isLoading.value = true;
    if(currentPage.value == 1) {
      history.value = RxList([
        // Add your initial history items here
      ]);
      stillMoreData.value = true;
    }
    var result = await api.getLatihanUsers(40, currentPage.value);

    var decodedData = jsonDecode(result.body);
    if(decodedData['status'] == 400) {
      stillMoreData.value = false;
      return;
    }
    //delayed 2 seconds

    // Parse dateTime and add to history list
    for (var item in decodedData['data']['latihan']) {
      try {
        var dateTimeString = item['dateTime'] as String?;
        var isCheckin = item['isCheckin'] as String?;

        if (dateTimeString != null && isCheckin != null) {
          var dateTime = DateTime.parse(dateTimeString);
          var date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
          var time = "${dateTime.hour}:${dateTime.minute}";
          var user = item['nama'] as String?;

          if (isCheckin == "1") {
            history.value
                .add({"user": user,"date": date, "time": time, "status": "checkin"});

          } else {
            history.value
                .add({"user": user,"date": date, "time": time, "status": "checkout"});

          }
        }
        isLoading.value = false;
            print(history.value);

      } catch (e) {
        print("Error parsing dateTime: $e");
        // Handle parsing errors here
      }
    }
  }
}
