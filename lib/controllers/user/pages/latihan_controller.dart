import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymapp/controllers/user/pages/dashboard_controller.dart';
import 'package:gymapp/network/api.dart';

class LatihanController extends GetxController {
  final RxInt isCheckIn = 0.obs;
  DashboardController dashboardController = Get.find<DashboardController>();
  var isSubscribed = 0.obs;
  final Api api = Get.put(Api());
  var box = GetStorage();
  var isLoading = false.obs;
  var history = RxList([
    // Add your initial history items here
  ]).obs;

  Future<void> getLatihan() async {
    await dashboardController.getMembership();
    //get membership from box storage me or from api
    if (dashboardController.membership.value != "") {
      if (DateTime.tryParse(dashboardController.membership.value)!
          .isAfter(DateTime.now())) {
        isSubscribed.value = 1;
      } else {
        isSubscribed.value = 0;
      }
    }

    history.value = RxList([
      // Add your initial history items here
    ]);

    var result = await api.getLatihan(10);
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
      } catch (e) {
        print("Error parsing dateTime: $e");
        // Handle parsing errors here
      }
    }
    //delayed
  }

  Future<void> checkIn() async {
    isLoading = true.obs;
    var result = await api.addLatihan();
    result = jsonDecode(result.body);
    var isCheckin = result['data']['latihan']['isCheckin']!;
    var dateTime = result['data']['latihan']['dateTime']!;
    print(result);
    if (isCheckin == "1") {
      isCheckIn.value = 1;
    } else if (isCheckin == "0") {
      isCheckIn.value = 0;
    }
    dateTime = DateTime.parse(dateTime);
    var date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    var time = "${dateTime.hour}:${dateTime.minute}";
    if (isCheckin == "1") {
      history.value
          .insert(0, {"date": date, "time": time, "status": "checkin"});
    } else if (isCheckin == "0") {
      history.value
          .insert(0, {"date": date, "time": time, "status": "checkout"});
    }
    //delete box list latihan
    await box.remove('listLatihan');
    await getLatihan();
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false.obs;
  }
}
