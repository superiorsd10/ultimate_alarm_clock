import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_alarm_clock/app/modules/bottomNavigationBar/controllers/bottom_nav_bar_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/home/views/home_view.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/views/timer_view.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  BottomNavBarView({Key? key}) : super(key: key);

  BottomNavBarController bottomNavBarController =
      Get.find<BottomNavBarController>();

  final List<Widget> pages = [
    HomeView(),
    TimerView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => pages[controller.activeTabIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          useLegacyColorScheme: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.alarm),
              label: 'Alarm',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Timer',
            ),
          ],
          onTap: (index) {
            bottomNavBarController.changeTabIndex(index);
          },
          currentIndex: bottomNavBarController.activeTabIndex.value,
        ),
      ),
    );
  }
}
