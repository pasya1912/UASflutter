import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/user/pages/profile_controller.dart';
import 'package:gymapp/network/api.dart';



class EditAlamatController extends GetxController {
  final TextEditingController alamatController = TextEditingController();
  final ProfileController profileController = Get.find<ProfileController>();
  final Api api = Get.find<Api>();



  @override
  void onClose() {
    alamatController.dispose();
    super.onClose();
  }

  void updateAlamat() {
    
    if (alamatController.text.isNotEmpty && alamatController.text != profileController.alamat.value) {
      var data = {
        'alamat': alamatController.text,
      };
      api.updateProfile(data).then((response) {
        var result = jsonDecode(response.body!); 
        if (result['status'] == 200) {
          profileController.alamat.value = alamatController.text;
          Get.back();
          Get.snackbar('Success', 'Alamat berhasil diupdate');
        }
        else {
          Get.snackbar('Error', result['message']);
        }
      });
    }
  }
}