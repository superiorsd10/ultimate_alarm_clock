import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:ultimate_alarm_clock/app/modules/settings/controllers/theme_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/timerRing/controllers/timer_ring_controller.dart';
import 'package:ultimate_alarm_clock/app/utils/constants.dart';

class TimerControlView extends GetView<TimerControlController> {
  ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.3,
                    bottom: height * 0.2,
                  ),
                  child: Text(
                    'Time\'s up!',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: themeController.isLightMode.value
                              ? kLightPrimaryTextColor
                              : kprimaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  height: height * 0.06,
                  width: width * 0.8,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        kprimaryColor,
                      ),
                    ),
                    onPressed: () async {
                      controller.stopForegroundService();
                      await FlutterRingtonePlayer.stop();
                      Get.offAllNamed('/bottom-nav-bar');
                      // Get.back();
                    },
                    child: Text(
                      'Stop',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: themeController.isLightMode.value
                                ? kLightPrimaryTextColor
                                : ksecondaryTextColor,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Get.snackbar(
          'Note',
          "You can't go back while the timer is ringing",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      },
    );
  }
}
