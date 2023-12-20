import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/admin/pages/dashboard.dart';
import 'package:gymapp/admin/pages/latihan.dart';
import 'package:gymapp/admin/pages/users.dart';
import 'package:gymapp/controllers/admin/home_controller.dart';

import 'package:line_icons/line_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AdminHomePage extends StatelessWidget {
  final String? title;
  const AdminHomePage({super.key,  this.title});

  @override
  Widget build(BuildContext context) {
    final AdminHomeController controller = Get.put(AdminHomeController());
    List<Widget> widgetOptions = <Widget>[
      AdminLatihan(),
      const AdminDashboard(),
      const AdminUsers(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Gym App'),
        centerTitle: true,
      ),
      body: PageView(
        controller: controller.pageController,
        children: widgetOptions,
        onPageChanged: (index) {
          controller.updateIndex(index);
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GetBuilder<AdminHomeController>(
              builder: (controller) => Obx(() => GNav(
                    tabs: const [
                      GButton(
                        icon: LineIcons.checkCircle,
                        text: 'Latihan',
                      ),
                      GButton(
                        icon: LineIcons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: LineIcons.users,
                        text: 'Users',
                      ),
                    ],
                    selectedIndex: controller.selectedIndex.value,
                    onTabChange: (index) {
                      controller.updateIndex(index);
                      controller.pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
