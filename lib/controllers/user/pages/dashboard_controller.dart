import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymapp/network/api.dart';

class DashboardController extends GetxController {
  final api = Get.put(Api());
  final box = GetStorage();
  var membership = "".obs;

  Future<bool> getMembership() async {
    //get membership from box storage me or from api
    var me = box.read('me');

    if (me != null) {
      var expiredTimeString = me['expired'] as String?; // Retrieve as String

      if (expiredTimeString != null) {
        var expiredTime = DateTime.tryParse(expiredTimeString);
        if (expiredTime != null && expiredTime.isAfter(DateTime.now())) {
          
          var meValue = me['value']!;
          
          //if membership not null and membership is not expired

          if (meValue['membership'] != null) {
            var parsedMembership = DateTime.tryParse(meValue['membership']);
            if (parsedMembership!.isAfter(DateTime.now())) {
              membership.value = meValue['membership'];
              return Future.value(true);
            } else {
              return Future.value(false);
            }
          }
        }
      }
    }
    

    var getMe = api.me().then((response) {
      var result = jsonDecode(response.body!);
      var user = result['data']['user']!;
      var expiredTime = DateTime.now().add(const Duration(seconds: 30));
      box.write('me', {
        'value': user,
        'expired': expiredTime.toIso8601String(), // Convert DateTime to String
      });
      if (user['membership'] != null) {
        
        var parsedMembership = DateTime.tryParse(user['membership']);
        if (parsedMembership!.isAfter(DateTime.now())) {
          membership.value = user['membership'];
          return Future.value(true);
        }
      } else {
        return Future.value(false);
      }
      return Future.value(false);
    });
    return getMe;
  }
}
