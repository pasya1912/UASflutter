import 'package:flutter/material.dart';
import 'package:gymapp/pages/homepage.dart';
import 'package:gymapp/pages/profile/edit_alamat.dart';
import 'package:gymapp/pages/profile/edit_nama.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int isIdVerified = 1;
  final String nama = "Rafli Pasya";
  final String alamat = "jl. metro jaya 1";

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(children: [
          buildUserInfoDisplay(nama, "Nama",  EditNama(nama: nama)),
          buildUserInfoDisplay(alamat, "Alamat",  EditAlamat(alamat: alamat)),
          isVerified(),
          //logout button in flutter
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              ),
              //text color if button is not pressed normal if pressed text white
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.white;
                  else
                    return Colors.black; // Use the component's default.
                },
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                //if pressed
                if (states.contains(MaterialState.pressed))
                  return Colors.red;
                else
                  return null; // Defer to the widget's default.
              }),
              overlayColor: MaterialStateColor.resolveWith(
                (states) =>
                    Colors.transparent, // Defer to the widget's default.
              ),
            ),
            onPressed: () {},
            child: Text('Logout'),
          )
        ]));
  }

  Widget isVerified() {
    if (isIdVerified == 1) {
      return buildUserInfoDisplay("Verified", "Verifikasi ID", const HomePage(),
          const TextStyle(color: Colors.green));
    } else {
      return buildUserInfoDisplay("Unverified", "Verifikasi ID",
          const HomePage(), const TextStyle(color: Colors.red));
    }
  }

  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage,
          [final textStyling]) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => editPage),
                        );
                      },
                      child: Row(children: [
                        Expanded(child: Text(getValue, style: textStyling ?? const TextStyle(color: Colors.black))),
                        const SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              size: 15.0,
                            ))
                      ])))
            ],
          ));
}
