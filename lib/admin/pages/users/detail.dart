import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/admin/pages/users/add_membership.dart';

import 'package:gymapp/controllers/admin/pages/users/detail_user_controller.dart';

class UserDetail extends StatelessWidget {
  final int? id;
  final String? nama;
  final String? nomor;
  final String? alamat;
  final String? membership;

  const UserDetail(
      {Key? key, this.id, this.nama, this.nomor, this.alamat, this.membership})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailUserController controller = Get.put(DetailUserController());
    return Scaffold(
      appBar: AppBar(title: const Text("User Detail")),
      //body is form to add user is consist of nama, nomor, alamat, password and save button
      body: ListView(
        children: [
          //display icon user
          const Icon(
            Icons.person,
            size: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //display nama
                const Text("Nama:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  readOnly: true,
                  controller: controller.namaController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: nama,
                    // Override text style for disabled field
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey, // Change the color of the border
                      ),
                    ),
                    // Override text style for disabled field
                    enabled: false,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Nomor:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  readOnly: true,
                  controller: controller.nomorController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: nomor,
                    // Override text style for disabled field
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey, // Change the color of the border
                      ),
                    ),
                    // Override text style for disabled field
                    enabled: false,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor tidak boleh kosong';
                    }

                    //nomor must start with 08 and 11 digits
                    if (!value.startsWith('08') || value.length >= 13) {
                      return 'Nomor harus diawali dengan 08 dan 13 digit';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Alamat:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  readOnly: true,
                  controller: controller.alamatController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: alamat,
                    // Override text style for disabled field
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey, // Change the color of the border
                      ),
                    ),
                    // Override text style for disabled field
                    enabled: false,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Membership:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  readOnly: true,
                  controller: controller.passwordController,
                  decoration: MembershipDecoration(membership, controller),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          //button to add membership duration
          if (controller.membershipStatus(membership) <= 1) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to( AddMembership(id: id));
                      },
                      child: const Text('Add Membership'),
                    ),
                  ),
                ),
              ],
            )
          ]
        ],
      ),
    );
  }

  InputDecoration MembershipDecoration(
      var membership, DetailUserController controller) {
    var textColor;
    var labelText;
    var membershipStatus = controller.membershipStatus(membership);
    //check if membership is not null and not expired
    if (membershipStatus == 2) {
      textColor = Colors.green;
      labelText = membership;
    } else if (membershipStatus == 1) {
      textColor = Colors.red;
      labelText = "$membership (Expired)";
    } else {
      textColor = Colors.red;
      labelText = "never";
    }
    return InputDecoration(
      labelStyle: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(),
      labelText: labelText,
      // Override text style for disabled field
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey, // Change the color of the border
        ),
      ),
      // Override text style for disabled field
      enabled: false,
    );
  }
}
