import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:gymapp/network/api.dart';

class AddMembershipController extends GetxController {
  TextEditingController hariController = TextEditingController();

  var iduser = 0.obs;
  Api api = Get.find<Api>();

  bool isEmpty() {
    if (hariController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Form tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return true;
    } else {
      return false;
    }
  }

  Future<void> add(int? idUser) async {
    if (isEmpty()) {
      return;
    }
    var hari = hariController.text;

    var result = await api.addMembership(idUser, hari);
    var check = jsonDecode(result.body);
    if (check['status'] == 200) {
      Get.back();
      Get.back();

      Get.snackbar(
        'Success',
        'Membership berhasil ditambahkan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Membership gagal ditambahkan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
