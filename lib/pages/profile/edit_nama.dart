//using Statefull Widget create a form to edit the name

import 'package:flutter/material.dart';

class EditNama extends StatefulWidget {
  final String nama;
  const EditNama({Key? key, required this.nama}) : super(key: key);

  @override
  State<EditNama> createState() => _EditNamaState();
}

class _EditNamaState extends State<EditNama> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.nama;
    //form to edit the name
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Nama'),
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
                child: const Text('Update'),
              ),
            ],
          ),
        )));
  }
}
