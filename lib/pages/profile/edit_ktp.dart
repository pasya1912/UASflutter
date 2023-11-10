import 'package:flutter/material.dart';

class EditKTP extends StatefulWidget {
  const EditKTP({super.key});

  @override
  State<EditKTP> createState() => _EditKTPState();
}

class _EditKTPState extends State<EditKTP> {
  final _formKey = GlobalKey<FormState>();
  final ktpController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    ktpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      child: Image.network(
                          "https://dukcapil.pesawarankab.go.id/images/artikel/uploads/268_FOTO.JPG.jpg")),
                  Container(
                    width: 125.0,
                    height: 25.0,
                    color: Colors.grey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('Verified', textAlign: TextAlign.center)],
                    ),
                  ),
                ],
              ),
            )));
  }
}
