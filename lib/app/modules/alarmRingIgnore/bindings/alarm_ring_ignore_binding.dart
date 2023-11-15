import 'package:get/get.dart';
import 'package:ultimate_alarm_clock/app/modules/bottomNavigationBar/controllers/bottom_nav_bar_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/settings/controllers/settings_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/settings/controllers/theme_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/controllers/timer_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/timerRing/controllers/timer_ring_controller.dart';

import '../controllers/alarm_ring_ignore_controller.dart';

class AlarmControlIgnoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlarmControlIgnoreController>(
      () => AlarmControlIgnoreController(),
    );
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
    Get.put<ThemeController>(
      ThemeController(),
    );
    Get.lazyPut<TimerController>(
      () => TimerController(),
    );
    Get.lazyPut<BottomNavBarController>(
      () => BottomNavBarController(),
    );
    Get.lazyPut<TimerControlController>(
      () => TimerControlController(),
    );
  }
}
