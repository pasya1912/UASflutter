import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/user/pages/profile/edit_nama_controller.dart';



class EditNama extends StatelessWidget {
  final String nama;
  const EditNama({Key? key, required this.nama}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditNamaController controller = Get.put(EditNamaController());

    controller.nameController.text = nama;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Nama'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  hintText: 'Nama',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                controller.updateNama();
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
