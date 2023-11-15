import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:ultimate_alarm_clock/app/modules/settings/controllers/theme_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/controllers/timer_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/views/draggable_timer_widget.dart';
import 'package:ultimate_alarm_clock/app/utils/constants.dart';
import 'package:ultimate_alarm_clock/app/utils/utils.dart';

class TimerView extends GetView<TimerController> {
  TimerView({Key? key}) : super(key: key);

  ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height / 7.9),
        child: AppBar(
          toolbarHeight: height / 7.9,
          elevation: 0.0,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Utils.hapticFeedback();
                controller.saveTimerStateToStorage();
                Get.toNamed('/settings');
              },
              icon: const Icon(
                Icons.settings,
                size: 27,
              ),
              color: themeController.isLightMode.value
                  ? kLightPrimaryTextColor.withOpacity(0.75)
                  : kprimaryTextColor.withOpacity(0.75),
            ),
          ],
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            ListView(
              children: [
                Container(
                  color: themeController.isLightMode.value
                      ? kLightPrimaryBackgroundColor
                      : kprimaryBackgroundColor,
                  height: height * 0.32,
                  width: width,
                  child: Obx(() => TimePickerSpinner(
                    time: DateTime(0, 0, 0, 0, 1, 0),
                    minutesInterval: 1,
                    secondsInterval: 1,
                    is24HourMode: true,
                    isShowSeconds: true,
                    alignment: Alignment.center,
                    normalTextStyle:
                        Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: themeController.isLightMode.value
                                  ? kLightPrimaryDisabledTextColor
                                  : kprimaryDisabledTextColor,
                            ),
                    highlightedTextStyle:
                        Theme.of(context).textTheme.displayMedium,
                    onTimeChange: (dateTime) {
                      Utils.hapticFeedback();
                      controller.remainingTime.value = Duration(
                        hours: dateTime.hour,
                        minutes: dateTime.minute,
                        seconds: dateTime.second,
                      );
                    },
                  ),),
                ),
              ],
            ),
            Visibility(
              visible: controller.isTimerRunning.value,
              child: Align(
                alignment: Alignment.centerRight,
                child: DraggableTimerWidget(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => AbsorbPointer(
          absorbing: controller.remainingTime.value.inHours == 0 &&
                  controller.remainingTime.value.inMinutes == 0 &&
                  controller.remainingTime.value.inSeconds == 0
              ? true
              : false,
          child: FloatingActionButton(
            key: controller.scaffoldKey,
            onPressed: controller.isTimerRunning.value
                ? () {
                    Get.snackbar(
                        'Timer In Progress',
                        'A timer is already running. Either wait '
                            'or cancel the previous timer.');
                  }
                : controller.startTimer,
            backgroundColor: controller.remainingTime.value.inHours == 0 &&
                    controller.remainingTime.value.inMinutes == 0 &&
                    controller.remainingTime.value.inSeconds == 0
                ? kprimaryDisabledTextColor
                : kprimaryColor,
            child: const Icon(
              Icons.play_arrow_rounded,
            ),
          ),
        ),
      ),
    );
  }
}
