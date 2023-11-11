import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  children: [
                    (() {
                      if (subsActive == 1) {
                        return SubscribedBanner();
                      } else {
                        return NotSubscribeBanner();
                      }
                    }())
                  ],
                ),
              ),
            ),
          ],
        ),
        //text has margin left 5
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            'Alat yang Tersedia:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        //divider line
        const Divider(
          height: 20,
          thickness: 2,
          indent: 5,
          endIndent: 5,
        ),
        Column(
          children: [
            MacamAlat(
                namaAlat: "Flat Bench",
                otot: const ["Dada", "Trisep"],
                image: "assets/images/alat/flatbench.jpg"),
            MacamAlat(
                namaAlat: "Incline Bench",
                otot: const ["Dada Atas", "Trisep"],
                image: "assets/images/alat/inclinebench.webp"),
            MacamAlat(
                namaAlat: "Decline Bench",
                otot: const ["Dada Bawah", "Trisep"],
                image: "assets/images/alat/declinebench.jpg"),
            MacamAlat(
                namaAlat: "Cable Crossover",
                otot: const ["Punggung", "Bisep"],
                image: "assets/images/alat/cablecrossover.webp"),
            MacamAlat(
                namaAlat: "Lat Pulldown",
                otot: const ["Punggung", "Bisep"],
                image: "assets/images/alat/latpulldown.webp"),
          ],
        ),
      ]),
    );
  }

  Widget SubscribedBanner() => Column(children: [
        Text(
          'Membership Active',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        Text('Expiry Date: 20/12/2023'),
      ]);

  Widget NotSubscribeBanner() => Column(children: [
        Text(
          'Not Subscribed',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        Text('Silahkan kontak kasir untuk berlangganan'),
      ]);
}

class MacamAlat extends StatelessWidget {
  final String namaAlat;
  final List<String> otot;
  final String? image;

  MacamAlat({required this.namaAlat, required this.otot, this.image, Key? key})
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
                width: 600,
                height: 400,
                child: ListView(children: [
                  Column(children: [
                    if (image != null) ...[
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Row(children: [Text(namaAlat)]),
                          Row(children: [Text('Otot: $ototJoined')]),
                        ],
                      ),
                    ),
                  ]),
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
