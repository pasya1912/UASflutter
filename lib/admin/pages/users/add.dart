import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/admin/pages/users/add_user_controller.dart';

class UserAdd extends StatelessWidget {
  const UserAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddUserController controller = Get.put(AddUserController());
    return Scaffold(
      appBar: AppBar(title: const Text("Add User")),
      //body is form to add user is consist of nama, nomor, alamat, password and save button
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller.namaController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Nama',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller.nomorController,
              keyboardType: TextInputType.number,
              maxLength: 13,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Nomor',
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller.alamatController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Alamat',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Alamat tidak boleh kosong';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password tidak boleh kosong';
                }
                return null;
              },
            ),
          ),
          //save button that half of the screen
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width / 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addUser();
                    },
                    child: const Text('Save'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
