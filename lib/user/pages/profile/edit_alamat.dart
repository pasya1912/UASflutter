import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/user/pages/profile/edit_alamat_controller.dart';

class EditAlamat extends StatelessWidget {
  final String alamat;

  const EditAlamat({Key? key, required this.alamat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditAlamatController controller = Get.put(EditAlamatController());
    controller.alamatController.text = alamat;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Alamat'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: controller.alamatController,
                decoration: const InputDecoration(
                  hintText: 'Alamat',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                controller.updateAlamat();
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
