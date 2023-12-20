import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:gymapp/controllers/user/pages/dashboard_controller.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getMembership();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    //margin x = 5
                    width: double.infinity,
                    height: 100,
                    //container again with full width but margin x = 5
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      //colors from rgb 211,211,211
                      color: const Color.fromARGB(255, 211, 211, 211),
                    ),
                    child: Column(
                      //align center
                      mainAxisAlignment: MainAxisAlignment.center,
                      //display the membership status and expiry date
                      children: [
                        FutureBuilder(
                          future: controller.getMembership(),
                          builder: (context, snapshot) {
                            print("Called Snapshot");
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasData) {
                              //warp the data with Obx
                              return Obx(() {
                                //if the membership is not empty and the expiry date is after today
                                if (controller.membership.value != '' &&
                                    DateTime.parse(controller.membership.value)
                                        .isAfter(DateTime.now())) {
                                  return SubscribedBanner(
                                      controller.membership.value);
                                } else {
                                  return NotSubscribeBanner();
                                }
                              });
                            } else {
                              return const Center(
                                child: Text('Failed to fetch data.'),
                              );
                            }
                          },
                        ),
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
          ],
        ),
      ),
    );
  }

  Widget SubscribedBanner(String? expiry) => Column(children: [
        Text(
          'Membership Active',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        Text('Expiry Date: $expiry'),
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

  const MacamAlat({
    required this.namaAlat,
    required this.otot,
    this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String ototJoined = otot.join(', ');

    return TextButton(
      // Replace GestureDetector with TextButton or ElevatedButton
      onPressed: () {
        _showModal(context); // Call method to show modal on button press
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: 50,

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

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.infinity,
            height: 200,
            child: Column(
              children: [
                // Add any content for the modal here
/*                 Image.asset('assets/images/${image ?? ''}.png'),
 */                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Text(namaAlat),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
