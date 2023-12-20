import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/controllers/admin/pages/dashboard_controller.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminDashboardController controller = Get.put(AdminDashboardController());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getDashboard();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            _buildBanner(),
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
                  _buildContainer(Colors.blue.shade600, "Today\nCheckin Member",
                      controller, 'today_checkin'),
                  _buildContainer(Colors.green.shade600, "Active\nMember",
                      controller, 'active_member'),
                ],
              ),
            ),
            //logout button
            Row(children: [
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.logout();
                    },
                    child: const Text('Logout'),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _homeBanner(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _homeBanner() {
    return Column(
      children: [
        Text(
          'Fitness Station Gym',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildContainer(
      Color color, String title, AdminDashboardController value, String key) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      width: MediaQuery.of(Get.context!).size.width * 0.45,
      height: 150,
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              shadows: List.generate(
                5,
                (index) => Shadow(
                  color: Colors.grey.shade600,
                  blurRadius: 2,
                  offset: const Offset(1, 1),
                ),
              ),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder(
            future: value.getDashboard(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(() {
                  if (!value.isLoading.value) {
                    return Text(
                      value.data[key].toString(),
                      style: TextStyle(
                        shadows: List.generate(
                          1,
                          (index) => Shadow(
                            color: Colors.black,
                            blurRadius: 2,
                            offset: const Offset(1, 1),
                          ),
                        ),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    );
                  } else {
                    //loading
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
