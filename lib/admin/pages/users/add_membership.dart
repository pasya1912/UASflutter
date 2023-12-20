import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/admin/pages/users/add_membership_controller.dart';

class AddMembership extends StatelessWidget {
  final int? id;
  const AddMembership({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    //form to add membership consist of number of days and suggestion 
    AddMembershipController controller = Get.put(AddMembershipController());
    return Scaffold(
      appBar: AppBar(title: const Text("Add Membership")),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller.hariController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Jumlah Hari',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Jumlah hari tidak boleh kosong';
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.add(id);
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }
}