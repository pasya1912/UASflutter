import 'dart:convert';

import 'package:get/get.dart';
import 'package:gymapp/controllers/session_controller.dart';
import 'package:gymapp/network/api.dart';

class AdminDashboardController extends GetxController {
  //session controller
  SessionController sessionController = Get.find<SessionController>();
  final Api api = Get.put(Api());
  var data = {}.obs;
  var isLoading = false.obs;

  Future getDashboard() async {
    isLoading.value = true;
    print('getDashboard');
    var response = await api.getDashboard();
    response = jsonDecode(response.body);
    print(response);
    data.value = response['data'];
    isLoading.value = false;
    return Future.value(true);

  }

  void logout() {
    api.logout();
  }
}
