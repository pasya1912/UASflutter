import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymapp/user/pages/latihan.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gymapp/controllers/user/home_controller.dart';
import 'package:gymapp/user/pages/dashboard.dart';
import 'package:gymapp/user/pages/profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    const List<Widget> widgetOptions = <Widget>[
      Latihan(),
      Dashboard(),
      Profile(),
    ];

    final HomeController controller = Get.put(HomeController());

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
            child: GetBuilder<HomeController>(
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
                        icon: LineIcons.user,
                        text: 'Profile',
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
