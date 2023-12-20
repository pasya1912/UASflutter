import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/network/api.dart';

class EditPasswordController extends GetxController {
  final TextEditingController oldpasswordController = TextEditingController();
  RxBool isOldPasswordVisible = true.obs;
  RxBool isNewPasswordVisible = true.obs;
  RxBool isKonfirmasiNewPasswordVisible = true.obs;
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController konfirmasiNewPasswordController =
      TextEditingController();
  final api = Get.find<Api>();
  RxBool isLoading = false.obs;

  @override
  void onClose() {
    newpasswordController.dispose();
    konfirmasiNewPasswordController.dispose();
    super.onClose();
  }

  void updatePassword() {
    if (newpasswordController.text.isNotEmpty &&
        konfirmasiNewPasswordController.text.isNotEmpty) {
      if (newpasswordController.text == konfirmasiNewPasswordController.text) {
        //update password using api update profile
        var data = {
          'old_password': oldpasswordController.text,
          'new_password': konfirmasiNewPasswordController.text,
        };

        api.updateProfile(data).then((response) {
          var result = jsonDecode(response.body!);
          if (result['status'] == 200) {
            Get.back();
            Get.snackbar('Success', 'Password berhasil diupdate');
          } else {
            Get.snackbar('Error', result['message']);
          }
        });
      } else {
        Get.snackbar('Error', 'Password tidak sama');
      }
    } else {
      Get.snackbar('Error', 'Password tidak boleh kosong');
    }
    //delay 1 detik to isLoading false
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
    });
  }
}
