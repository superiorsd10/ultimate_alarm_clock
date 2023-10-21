import 'package:get/get.dart';
import 'package:ultimate_alarm_clock/app/modules/bottomNavigationBar/controllers/bottom_nav_bar_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/settings/controllers/settings_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/settings/controllers/theme_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/controllers/timer_controller.dart';

class TimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BottomNavBarController>(
      BottomNavBarController(),
    );
    Get.put<TimerController>(
      TimerController(),
    );
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
    Get.put<ThemeController>(
      ThemeController(),
    );
  }
}
