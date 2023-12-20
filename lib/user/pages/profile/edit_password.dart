import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/user/pages/profile/edit_password_controller.dart';

class EditPassword extends StatelessWidget {
  const EditPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final EditPasswordController controller = Get.put(EditPasswordController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Obx(
          () => Column(
            children: [
              //old password
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  obscureText: controller.isOldPasswordVisible.value,
                  controller: controller.oldpasswordController,
                  decoration: InputDecoration(
                    hintText: 'Old Password',
                    suffixIcon: InkWell(
                      onTapDown: (event) {
                        controller.isOldPasswordVisible.value = false;
                      },
                      onTapUp: (event) {
                        controller.isOldPasswordVisible.value = true;
                      },
                      child: Icon(controller.isOldPasswordVisible.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  obscureText: controller.isNewPasswordVisible.value,
                  controller: controller.newpasswordController,
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    suffixIcon: InkWell(
                      onTapDown: (event) {
                        controller.isNewPasswordVisible.value = false;
                      },
                      onTapUp: (event) {
                        controller.isNewPasswordVisible.value = true;
                      },
                      child: Icon(controller.isNewPasswordVisible.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  obscureText: controller.isKonfirmasiNewPasswordVisible.value,
                  controller: controller.konfirmasiNewPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    suffixIcon: InkWell(
                      onTapDown: (event) {
                        controller.isKonfirmasiNewPasswordVisible.value = false;
                      },
                      onTapUp: (event) {
                        controller.isKonfirmasiNewPasswordVisible.value = true;
                      },
                      child: Icon(
                          controller.isKonfirmasiNewPasswordVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if(controller.isLoading.value) return;
                  controller.isLoading.value = true;
                  controller.updatePassword();
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
