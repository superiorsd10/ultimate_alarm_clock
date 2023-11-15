import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_alarm_clock/app/modules/bottomNavigationBar/controllers/bottom_nav_bar_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/controllers/timer_controller.dart';
import 'package:ultimate_alarm_clock/app/utils/constants.dart';

class StartTimerView extends GetView<TimerController> {
  StartTimerView({super.key});

  // final bottomNavBarController = Get.find<BottomNavBarController>();

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;

    return Scaffold(
      body: Center(
        child: Obx(() {
          final hours = controller.strDigits(
            controller.remainingTime.value.inHours.remainder(24),
          );
          final minutes = controller.strDigits(
            controller.remainingTime.value.inMinutes.remainder(60),
          );
          final seconds = controller.strDigits(
            controller.remainingTime.value.inSeconds.remainder(60),
          );
          return Text(
            '$hours:$minutes:$seconds',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: kprimaryTextColor,
              fontSize: 50,
            ),
          );
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Obx(
          () => Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: FloatingActionButton.small(
                  onPressed: controller.stopTimer,
                  child: const Icon(Icons.close),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(30, 10, 60, 10),
                child: FloatingActionButton(
                  onPressed: controller.isTimerPaused.value
                      ? controller.resumeTimer
                      : controller.pauseTimer,
                  child: Icon(
                    controller.isTimerPaused.value
                        ? Icons.play_arrow
                        : Icons.pause,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: Obx(
      //   () => BottomNavigationBar(
      //     useLegacyColorScheme: false,
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.alarm),
      //         label: 'Alarm',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.timer),
      //         label: 'Timer',
      //       ),
      //     ],
      //     onTap: (index) {
      //       if (index == 1 && bottomNavBarController.isTimerRunning.value) {
      //         bottomNavBarController.changeTab(2);
      //       } else {
      //         bottomNavBarController.changeTab(index);
      //       }
      //     },
      //     currentIndex: bottomNavBarController.activeTabIndex.value == 2
      //         ? 1
      //         : bottomNavBarController.activeTabIndex.value,
      //   ),
      // ),
    );
  }
}
