//using Statefull Widget create a form to edit the name

import 'package:flutter/material.dart';

class EditAlamat extends StatefulWidget {
  final String alamat;
  const EditAlamat({Key? key, required this.alamat}) : super(key: key);

  @override
  State<EditAlamat> createState() => _EditAlamatState();
}

class _EditAlamatState extends State<EditAlamat> {
  final _formKey = GlobalKey<FormState>();
  final alamatController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    alamatController.text = widget.alamat;
    //form to edit the name
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Alamat'),
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
                
                controller: alamatController,
                decoration: const InputDecoration(
                  hintText: 'Alamat',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
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
                          content: Text(alamatController.text),
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
