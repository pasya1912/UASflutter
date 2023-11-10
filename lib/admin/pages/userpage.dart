import 'package:flutter/material.dart';
import 'package:gymapp/admin/pages/homepage.dart';
import 'package:gymapp/admin/pages/user/addmembership.dart';

class AdminUserPage extends StatefulWidget {
  const AdminUserPage({super.key});

  @override
  State<AdminUserPage> createState() => _AdminUserPageState();
}

class _AdminUserPageState extends State<AdminUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "List User",
            style: TextStyle(fontSize: 24),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: ListView(
          children: [
            UserItem("Rafli Pasya", 1, "12/12/2023"),
            UserItem("Abdul Pasya", 0),
          ],
        ));
  }

  Widget UserItem(String nama, int status, [final date]) {
    return GestureDetector(
      onTap: () {
        // Handle tap event here, for example, show an image using a dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                width: double.infinity,
                height: 200,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(children: [Text("Nama :$nama")]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Row(
                      children: [
                        Text(
                          'Membership:',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        Text(
                          status == 1 ? " Activated" : " Not Activated",
                          style: TextStyle(
                              fontSize: 12,
                              color: status == 1 ? Colors.green : Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(
                                                255, 217, 255, 218))),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddMemberShip(nama: nama,)),
                                  );
                                },
                                child: Text("Add Membership"))
                          ]),
                    ),
                  ),
                ]),
              ),
            );
          },
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 211, 211, 211),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      nama,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        Text(
                          'Membership:',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        Text(
                          status == 1 ? " Activated" : " Not Activated",
                          style: TextStyle(
                              fontSize: 12,
                              color: status == 1 ? Colors.green : Colors.red),
                        ),
                        Text(
                          date == null ? "" : "($date)",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
