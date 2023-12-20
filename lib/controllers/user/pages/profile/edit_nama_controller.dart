import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/user/pages/profile_controller.dart';
import 'package:gymapp/network/api.dart';



class EditNamaController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final ProfileController profileController = Get.find<ProfileController>();
  final Api api = Get.find<Api>();



  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  void updateNama() {
    
    if (nameController.text.isNotEmpty && nameController.text != profileController.nama.value) {
      var data = {
        'nama': nameController.text,
      };
      api.updateProfile(data).then((response) {
        var result = jsonDecode(response.body!); 
        if (result['status'] == 200) {
          profileController.nama.value = nameController.text;
          Get.back();
          Get.snackbar('Success', 'Nama berhasil diupdate');
        }
        else {
          Get.snackbar('Error', result['message']);
        }
      });
    }
  }
}