import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/user/pages/latihan_controller.dart';
import 'package:gymapp/user/pages/latihan/latihan_history.dart';

class Latihan extends StatelessWidget {
  const Latihan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LatihanController controller = Get.put(LatihanController());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getLatihan();
        },
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Text(
                      "Latihan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: const Color.fromARGB(255, 33, 212, 243),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        color: controller.isSubscribed.value == 0
                            ? Colors.red.withOpacity(0.5)
                            : Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: controller.isSubscribed.value == 0
                          ? const Center(
                              child: Text(
                                "You are not subscribed",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : TextButton(
                              onPressed: () async {
                                if (controller.isLoading.value) return;

                                await controller.checkIn();
                              },
                              child: Text(
                                controller.isCheckIn.value == 0
                                    ? "Check In"
                                    : "Check Out",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: controller.isCheckIn.value == 0
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("History:"),
                      TextButton(
                          onPressed: () {
                            Get.to(const LatihanHistory());
                            controller.getLatihan();
                          },
                          child: Text("Semua")),
                    ],
                  ),
                )
              ],
            ),
            FutureBuilder<void>(
              future: controller.getLatihan(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error fetching data.'),
                  );
                } else {
                  return Obx(() {
                    if (controller.history.value.isEmpty) {
                      return Center(
                        child: Text("No history"),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.history.value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.history.value[index]["date"]!} ${controller.history.value[index]["time"]!}",
                              ),
                              (() {
                                if (controller.history.value[index]["status"] ==
                                    "checkin") {
                                  return Text(
                                    "Check In",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "Check Out",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  );
                                }
                              }())
                            ],
                          ),
                        );
                      },
                    );
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
