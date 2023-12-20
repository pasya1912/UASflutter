import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/admin/pages/users_controller.dart';
import 'package:gymapp/network/api.dart';

class AddUserController extends GetxController {
  TextEditingController namaController = TextEditingController();
  TextEditingController nomorController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AdminUsersController adminUsersController = Get.find<AdminUsersController>();
  Api api = Get.find<Api>();

  void addUser() async {
    var nama = namaController.text;
    var nomor = nomorController.text;
    var alamat = alamatController.text;
    var password = passwordController.text;

    var result = await api.addUser(nama, nomor, alamat, password);
    var check = jsonDecode(result.body);
    if (check['status'] == 200) {
      adminUsersController.get();
      Get.back();

      Get.snackbar(
        'Success',
        'User berhasil ditambahkan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'User gagal ditambahkan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
