import 'package:get/get.dart';
import 'package:ultimate_alarm_clock/app/modules/bottomNavigationBar/controllers/bottom_nav_bar_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/home/controllers/home_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/settings/controllers/settings_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/settings/controllers/theme_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/controllers/timer_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/timerRing/controllers/timer_ring_controller.dart';

import '../controllers/add_or_update_alarm_controller.dart';

class AddOrUpdateAlarmBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddOrUpdateAlarmController>(
      AddOrUpdateAlarmController(),
    );
    Get.put<HomeController>(
      HomeController(),
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
