import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditNomorController extends GetxController {
  final TextEditingController nomorController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    nomorController.dispose();
    super.onClose();
  }

  void updateNomor() {
    if (nomorController.text.isNotEmpty) {
      Get.dialog(
        AlertDialog(
          content: Text(nomorController.text),
        ),
      );
    }
  }
}

class EditNomor extends StatelessWidget {
  final String nomor;

  const EditNomor({Key? key, required this.nomor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditNomorController controller = Get.put(EditNomorController());
    controller.nomorController.text = nomor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Nomor'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.nomorController,
                      
                      decoration: const InputDecoration(
                        hintText: 'Nomor',
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(height: 10),
                    //display "nomor tidak dapat diubah"
                    const Text(
                      "Nomor tidak dapat diubah",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
