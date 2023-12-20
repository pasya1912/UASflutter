
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/admin/pages/users_controller.dart';
import 'package:gymapp/network/api.dart';

class DetailUserController extends GetxController {
  TextEditingController namaController = TextEditingController();
  TextEditingController nomorController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AdminUsersController adminUsersController = Get.find<AdminUsersController>();

  Api api = Get.find<Api>();

  int membershipStatus(var membership)
  {
    if(membership != null)
    {
      //check if membership is after now
      if(DateTime.parse(membership).isAfter(DateTime.now()))
      {
        return 2;
      }
      else
      {
        return 1;
      }
    }
    else
    {
      return 0;
    }

  }


}
