import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/admin/pages/latihan_controller.dart';

class AdminLatihan extends StatelessWidget {
  const AdminLatihan({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminlatihanController());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.currentPage.value = 1;
          await controller.getLatihan();
        },
        child: ListView(controller: controller.scrollController, children: [
          //title history list

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                const Text(
                  "History User Latihan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("User"),
                    Text("Date"),
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder<void>(
            future: controller.getLatihan(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching data.'),
                );
              } else {
                if (controller.history.value.isEmpty) {
                  return const Center(
                    child: Text("No history"),
                  );
                }
                return Obx(() => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.history.value.length + 1,
                      itemBuilder: (context, index) {
                        if (index < controller.history.value.length) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${controller.history.value[index]["user"]} : ",
                                    ),
                                    (() {
                                      if (controller.history.value[index]
                                              ["status"] ==
                                          "checkin") {
                                        return const Text(
                                          "Checkin",
                                          style: TextStyle(color: Colors.green),
                                        );
                                      } else {
                                        return const Text(
                                          "Checkout",
                                          style: TextStyle(color: Colors.red),
                                        );
                                      }
                                    }()),
                                  ],
                                ),
                                Text(
                                  "${controller.history.value[index]["date"]!} ${controller.history.value[index]["time"]!}",
                                ),
                              ],
                            ),
                          );
                        } else if (controller.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ));
              }
            },
          ),
        ]),
      ),
    );
  }
}
