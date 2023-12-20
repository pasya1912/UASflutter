import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymapp/admin/home_page.dart';


import 'package:gymapp/user/home_page.dart';
import 'package:gymapp/network/api.dart';


class LoginController extends GetxController {
  TextEditingController username_c = TextEditingController();
  final api = Get.put(Api());
  TextEditingController password_c = TextEditingController();
  // inisiasi untuk get_storage

      final box = GetStorage();



  // inisiasi fungsi login ke halaman homepage untuk save ke local data kita
  login()  {
    if (username_c.text.isNotEmpty && password_c.text.isNotEmpty) {
      api.login(username_c.text, password_c.text).then((response) {
        var result = jsonDecode(response.body);

        if (result['status'] == 200 && result['data']['token'] != null) {
          //save token
          box.write('role', result['data']['user']['role']);
          box.write('token', result['data']['token']);
          if(result['data']['user']['role'] == 'user'){
            Get.offAll(const HomePage());
            Get.snackbar('Success', 'Login berhasil !');
          }else if(result['data']['user']['role'] == 'admin'){
            Get.offAll( AdminHomePage());

            Get.snackbar('Success', 'Login berhasil !');
          }else{
            Get.snackbar('Failed', 'Something wrong !');
          }
        } else {
          Get.snackbar('Failed', 'Username atau password salah !');
        }
      });
    } else {
      Get.snackbar('Failed', 'Isi nomor password !');
    }
  }
}
