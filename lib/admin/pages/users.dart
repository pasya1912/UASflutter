import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/admin/pages/users/add.dart';
import 'package:gymapp/admin/pages/users/detail.dart';

import 'package:gymapp/controllers/admin/pages/users_controller.dart';

class AdminUsers extends StatelessWidget {
  const AdminUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminUsersController controller = Get.put(AdminUsersController());
    return Scaffold(
      //generate list of sample users with refresh indicator and listview
      body: RefreshIndicator(
          onRefresh: () async {
            await controller.get();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              FutureBuilder(
                future: controller.get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error fetching data.'),
                    );
                  } else {
                    return Obx(() {
                      if (controller.users.isEmpty &&
                          !controller.stillLoading.value) {
                        return const Center(
                          child: Text("No users"),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.users.length + 1,
                        itemBuilder: (context, index) {
                          if (index < controller.users.length) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(UserDetail(
                                  id: controller.users[index]?["id"],
                                  nama: controller.users[index]?["nama"],
                                  nomor: controller.users[index]?["nomor"],
                                  alamat: controller.users[index]?["alamat"],
                                  membership: controller.users[index]
                                      ?["membership"],
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: ListTile(
                                  tileColor: Colors.grey.shade200,
                                  leading: const Icon(Icons.person),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller.users[index]?["nama"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          // Set maxLines to ensure text doesn't overflow
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: MembershipStatus(
                                    controller.users[index]?["membership"],
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            );
                          } else {
                            if (controller.stillLoading.value) {
                              print("Still Loading");
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Container();
                            }
                          }
                        },
                      );
                    });
                  }
                },
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const UserAdd());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget MembershipStatus(user) {
    if (user == null || DateTime.parse(user).isBefore(DateTime.now())) {
      return Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Membership:",
                      // Set maxLines to ensure text doesn't overflow
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    //if the membership is empty then put never if membership not empty then put the expiry date
                    Text(
                      user == null ? "Never" : user + " (Expired)",
                      // Set maxLines to ensure text doesn't overflow
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
            child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Membership:",
                  // Set maxLines to ensure text doesn't overflow
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  user,
                  // Set maxLines to ensure text doesn't overflow
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        )),
      ],
    );
  }
}
