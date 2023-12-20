import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/user/pages/latihan/latihan_history_controller.dart';

class LatihanHistory extends StatelessWidget {
  const LatihanHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LatihanHistoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan History'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.currentPage.value = 1;
          await controller.getLatihan();
        },
        child: ListView(
          controller: controller.scrollController,
          children: [
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
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.history.value.length + 1,
                        itemBuilder: (context, index) {
                          if (index < controller.history.value.length) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${controller.history.value[index]["date"]!} ${controller.history.value[index]["time"]!}",
                                  ),
                                  (() {
                                    if (controller.history.value[index]
                                            ["status"] ==
                                        "checkin") {
                                      return const Text(
                                        "Check In",
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      );
                                    } else {
                                      return const Text(
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
                          } else {
                            if (controller.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }
                        },
                      ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
