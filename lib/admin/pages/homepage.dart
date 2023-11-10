import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int subsActive = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // create a banner like container displaying the membership status and expiry date
      body: ListView(children: [
        Row(
          children: [
            Expanded(
              child: Container(
                //margin x = 5
                width: double.infinity,
                height: 100,
                //container again with full width but margin x = 5
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  //colors from rgb 211,211,211
                  color: const Color.fromARGB(255, 211, 211, 211),
                ),
                child: Column(
                  //align center
                  mainAxisAlignment: MainAxisAlignment.center,
                  //display the membership status and expiry date
                  children: [homeBanner()],
                ),
              ),
            ),
          ],
        ),
        //text has margin left 5
        //divider line
        const Divider(
          height: 20,
          thickness: 2,
          indent: 5,
          endIndent: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  //shadow
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade600,
                      blurRadius: 2,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.45,
                height: 150,
                child: Column(children: [
                  Text(
                    "Today\nCheckin Member",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        shadows: List.generate(
                          5,
                          (index) => Shadow(
                            color: Colors.grey.shade600,
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text("100",
                      style: TextStyle(
                          shadows: List.generate(
                            1,
                            (index) => Shadow(
                              color: Colors.black,
                              blurRadius: 2,
                              offset: Offset(1, 1),
                            ),
                          ),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green))
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  //shadow
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade600,
                      blurRadius: 2,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                //width 40% of the screen
                width: MediaQuery.of(context).size.width * 0.45,
                height: 150,
                child: Column(children: [
                  Text("Subsribed\nMember",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          shadows: List.generate(
                            5,
                            (index) => Shadow(
                              color: Colors.grey.shade600,
                              blurRadius: 2,
                              offset: Offset(1, 1),
                            ),
                          ),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text("100",
                      style: TextStyle(
                          shadows: List.generate(
                            1,
                            (index) => Shadow(
                              color: Colors.black,
                              blurRadius: 2,
                              offset: Offset(1, 1),
                            ),
                          ),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green))
                ]),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget homeBanner() => Column(children: [
        Text(
          'Fitness Station Gym',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ]);
}

class MacamAlat extends StatelessWidget {
  final String namaAlat;
  final List<String> otot;

  MacamAlat({required this.namaAlat, required this.otot, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String ototJoined = otot.join(', ');
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
                  Image.asset('assets/images/$namaAlat.png'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(children: [Text(namaAlat)]),
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
                      "$namaAlat",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      'Otot: $ototJoined',
                      style: TextStyle(fontSize: 12, color: Colors.black),
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
