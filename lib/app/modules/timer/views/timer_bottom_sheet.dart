import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/controllers/timer_controller.dart';
import 'package:ultimate_alarm_clock/app/utils/constants.dart';

class TimerBottomSheet extends GetView<TimerController> {
  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
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
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: FloatingActionButton.small(
                  heroTag: 'stop',
                  onPressed: () {
                    controller.stopTimer(); 
                    controller.stopForegroundService(); 
                    Get.offAllNamed('/bottom-nav-bar');
                  },
                  child: const Icon(Icons.close),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 10, width / 4, 10),
                child: FloatingActionButton(
                  heroTag: 'pause',
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
      ],
    );
  }
}
