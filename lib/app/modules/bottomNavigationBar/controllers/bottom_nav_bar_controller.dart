import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_alarm_clock/app/data/providers/secure_storage_provider.dart';
import 'package:ultimate_alarm_clock/app/modules/home/views/home_view.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/controllers/timer_controller.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/views/timer_view.dart';

class BottomNavBarController extends GetxController
    with WidgetsBindingObserver {
  final activeTabIndex = 0.obs;
  final _secureStorageProvider = SecureStorageProvider();
  final isTimerRunning = false.obs;

  TimerController timerController = Get.find<TimerController>();

  List<Widget> pages = [
    HomeView(),
    TimerView(),
  ];

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _loadSavedState();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _saveState();
    }
  }

  void _loadSavedState() async {
    print('LOADING SAVED STATE OF BOTTOM NAV BAR');
    activeTabIndex.value = await _secureStorageProvider.readTabIndex();

    isTimerRunning.value = await _secureStorageProvider.readIsTimerRunning();

    if (isTimerRunning.value) {
      print('TIMER IS RUNNING');
      activeTabIndex.value = 1;
    }
  }

  void _saveState() async {
    await _secureStorageProvider.writeTabIndex(
      tabIndex: activeTabIndex.value,
    );
  }

  void changeTab(int index) {
    activeTabIndex.value = index;

    if (index == 0 &&
        (timerController.isTimerRunning.value || isTimerRunning.value)) {
      timerController.saveTimerStateToStorage();
    }
  }
}
