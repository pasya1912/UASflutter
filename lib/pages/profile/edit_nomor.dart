//using Statefull Widget create a form to edit the name

import 'package:flutter/material.dart';

class EditNomor extends StatefulWidget {
  final String nomor;
  const EditNomor({Key? key, required this.nomor}) : super(key: key);

  @override
  State<EditNomor> createState() => _EditNomorState();
}

class _EditNomorState extends State<EditNomor> {
  final _formKey = GlobalKey<FormState>();
  final nomorController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nomorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nomorController.text = widget.nomor;
    //form to edit the name
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Nomor'),
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
                
                controller: nomorController,
                decoration: const InputDecoration(
                  hintText: 'Nomor',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor tidak boleh kosong';
                  }
                  //check if the input is a number
                  if (int.tryParse(value) == null) {
                    return 'Nomor harus berupa angka';
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
                          content: Text(nomorController.text),
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
