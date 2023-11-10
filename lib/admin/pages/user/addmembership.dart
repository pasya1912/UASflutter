import 'package:flutter/material.dart';

class AddMemberShip extends StatefulWidget {
  final String nama;
  const AddMemberShip({super.key, required this.nama});

  @override
  State<AddMemberShip> createState() => _AddMemberShipState();
}

class _AddMemberShipState extends State<AddMemberShip> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final jumlahController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    jumlahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.nama;
    //form to edit the name
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Membership'),
        ),
        body: Padding(
            //padding vertical 30 horizontal 10
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                      //padding bottom 20
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'Nama',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      )),
                  Padding(
                      //padding bottom 20
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: jumlahController,
                        decoration: const InputDecoration(
                          hintText: 'Jumlah Bulan',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Jumlah Bulan tidak boleh kosong';
                          }
                          //check if the input is a number
                          if (int.tryParse(value) == null) {
                            return 'Jumlah Bulan harus berupa angka';
                          }
                          //check if the input is more than 0
                          if (int.parse(value) <= 0) {
                            return 'Jumlah Bulan harus lebih dari 0';
                          }
                          return null;
                        },
                      )),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              // Retrieve the text the that user has entered by using the
                              // TextEditingController.
                              content: Text(nameController.text),
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Tambah'),
                  ),
                ],
              ),
            )));
  }
}
