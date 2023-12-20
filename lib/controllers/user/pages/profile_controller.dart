import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymapp/controllers/session_controller.dart';
import 'package:gymapp/network/api.dart';

class ProfileController extends GetxController {
  final sessionController = Get.find<SessionController>();
  final api = Get.put(Api());
  final box = GetStorage();

  var isIdVerified = false.obs;
  var nama = "".obs;
  var nomor = "".obs;
  var alamat = "".obs;

  @override
  void onReady() {
    super.onReady();
    getProfile();
  }

  void getProfile() {
    print('Get profile');
    var me = box.read('me');
    if (me != null) {
      var expiredTimeString = me['expired'] as String?; // Retrieve as String

      if (expiredTimeString != null) {
        var expiredTime = DateTime.tryParse(expiredTimeString);
        if (expiredTime != null && expiredTime.isAfter(DateTime.now())) {
          var meValue = me['value'];
          if (meValue != null) {
            nama.value = meValue['nama'];
            alamat.value = meValue['alamat'];
            nomor.value = meValue['nomor'];
            return; // Exit early since we have valid data in cache
          }
        }
      }
    }

    // If cache is expired or not available, fetch from API
    api.me().then((response) {
      var result = jsonDecode(response.body!);


      var user = result['data']['user']!;

      var expiredTime = DateTime.now().add(const Duration(seconds: 30));
      box.write('me', {
        'value': user,
        'expired': expiredTime.toIso8601String(), // Convert DateTime to String
      });

      nama.value = user['nama'];
      alamat.value = user['alamat'];
      nomor.value = user['nomor'];
    }).catchError((error) {
      // Handle errors if needed
      print('Error fetching profile: $error');
    });
  }

  void logout() async {
    await api.logout();
  }
}
