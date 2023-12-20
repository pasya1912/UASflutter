import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/user/pages/profile_controller.dart';
import 'package:gymapp/user/pages/profile/edit_alamat.dart';

import 'package:gymapp/user/pages/profile/edit_nama.dart';
import 'package:gymapp/user/pages/profile/edit_nomor.dart';
import 'package:gymapp/user/pages/profile/edit_password.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(), // Initialize your controller
      builder: (controller) {
        return ListView(
          children: <Widget>[
            RefreshIndicator(
              onRefresh: () async {
                // Perform the refresh action here, e.g., recall the controller
                controller.getProfile(); // Refresh profile data
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Obx(
                  () => Column(
                    children: [
                      buildUserInfoDisplay(
                        controller.nama.value,
                        "Nama",
                        EditNama(nama: controller.nama.value),
                      ),
                      buildUserInfoDisplay(
                        controller.alamat.value,
                        "Alamat",
                        EditAlamat(alamat: controller.alamat.value),
                      ),
                      buildUserInfoDisplay(
                        controller.nomor.value,
                        "Nomor",
                        EditNomor(nomor: controller.nomor.value),
                      ),
                      buildUserInfoDisplay(
                        "*********************",
                        "Password",
                        const EditPassword(),
                        const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            // Button styles...
                            ),
                        onPressed: () {
                          controller.logout();
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildUserInfoDisplay(
    String getValue,
    String title,
    Widget editPage, [
    final TextStyle? textStyling,
    final Text? textBtn,
  ]) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 1),
            Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  bottom: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  // Navigate to editPage
                  Get.to(editPage);
                },
                child: Row(
                  children: [
                    Expanded(
                      child: textBtn ??
                          Text(
                            getValue,
                            style: textStyling,
                          ),
                    ),
                    const SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        size: 15.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
