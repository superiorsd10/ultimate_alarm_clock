import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/controllers/timer_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/views/timer_bottom_sheet.dart';
import 'package:ultimate_alarm_clock/app/utils/constants.dart';

class DraggableTimerWidget extends GetView<TimerController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AbsorbPointer(
        absorbing: controller.isTimerRunning.value ? false : false,
        child: InkWell(
          onTap: () => Get.bottomSheet(
            TimerBottomSheet(),
            backgroundColor: kprimaryBackgroundColor,
          ),
          child: Container(
            height: 40,
            width: 65,
            decoration: BoxDecoration(
              color: ksecondaryBackgroundColor,
              border: Border.all(
                color: kprimaryColor,
              ),
            ),
            child: Center(
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
                    fontSize: 12,
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
