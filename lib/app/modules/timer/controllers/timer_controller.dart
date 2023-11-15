import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_alarm_clock/app/data/models/alarm_handler_setup_model.dart';
import 'package:ultimate_alarm_clock/app/data/providers/secure_storage_provider.dart';
import 'package:ultimate_alarm_clock/app/modules/timer/views/timer_bottom_sheet.dart';
import 'package:ultimate_alarm_clock/app/utils/constants.dart';
import 'package:workmanager/workmanager.dart';

class TimerController extends GetxController
    with WidgetsBindingObserver, AlarmHandlerSetupModel {
  final initalTime = DateTime(0, 0, 0, 0, 1, 0).obs;
  final remainingTime = const Duration(hours: 0, minutes: 0, seconds: 0).obs;
  final currentTime = const Duration(hours: 0, minutes: 0, seconds: 0).obs;
  final startTime = 0.obs;
  final isTimerPaused = false.obs;
  final isTimerRunning = false.obs;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Rx<Timer?> countdownTimer = Rx<Timer?>(null);

  final SecureStorageProvider _secureStorageProvider = SecureStorageProvider();

  String strDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    loadTimerStateFromStorage();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      saveTimerStateToStorage();
    }
  }

  void saveTimerStateToStorage() async {
    // Save timer state (remaining time and start time) to local storage

    print('SAVED TO LOCAL STORAGE');

    print('WRITING REMAINING TIME: ${remainingTime.value.inSeconds}');

    // if(remainingTime.value.inSeconds <= 0){
    //   stopTimer();
    // }

    await _secureStorageProvider.writeRemainingTimeInSeconds(
      remainingTimeInSeconds: remainingTime.value.inSeconds,
    );
    await _secureStorageProvider.writeStartTime(
      startTime: startTime.value,
    );
    await _secureStorageProvider.writeIsTimerRunning(
      isTimerRunning: isTimerRunning.value,
    );
  }

  Future<void> loadTimerStateFromStorage() async {
    print('LOADING SAVED STATE OF RUNNING TIMER');
    final storedRemainingTimeInSeconds =
        await _secureStorageProvider.readRemainingTimeInSeconds();
    final storedStartTime = await _secureStorageProvider.readStartTime();
    isTimerRunning.value = await _secureStorageProvider.readIsTimerRunning();

    print('isTimerRunning: ${isTimerRunning.value}');

    print('storedRemainingTimeInSeconds: $storedRemainingTimeInSeconds');
    print('storedStartTime: $storedStartTime');

    if (storedRemainingTimeInSeconds != -1 && storedStartTime != -1) {
      final elapsedMilliseconds =
          DateTime.now().millisecondsSinceEpoch - storedStartTime;
      final elapsedSeconds = (elapsedMilliseconds / 1000).round();
      final updatedRemainingTimeInSeconds =
          storedRemainingTimeInSeconds - elapsedSeconds;

      print(
          'UPDATED REMAINING TIME IN SECONDS: $updatedRemainingTimeInSeconds');

      if (updatedRemainingTimeInSeconds > 0) {
        // Update remaining time and start timer from the correct point
        int hours = updatedRemainingTimeInSeconds ~/
            3600; // Calculate the number of hours
        int remainingSeconds = updatedRemainingTimeInSeconds %
            3600; // Calculate the remaining seconds
        int minutes = remainingSeconds ~/ 60; // Calculate the number of minutes
        int seconds = remainingSeconds % 60; // Calculate the number of seconds
        remainingTime.value = Duration(
          hours: hours,
          minutes: minutes,
          seconds: seconds,
        );
        print('REMAINING TIME AFTER LOADING STATE: ${remainingTime.value}');
        startTimer();
      } else {
        // Timer has completed; clear the stored data
        print('REMOVING THE TIMER DATA');
        await _secureStorageProvider.removeRemainingTimeInSeconds();
        await _secureStorageProvider.removeStartTime();
        stopTimer();
      }
    }
  }

  void startTimer() async {
    print('START THE TIMER');
    print('remainingTime: ${remainingTime.value}');
    if (remainingTime.value.inSeconds > 0) {
      final now = DateTime.now();
      startTime.value = now.millisecondsSinceEpoch;
      isTimerRunning.value = true;
      // Get.toNamed('/start-timer-view');
      // createForegroundTask();
      // await startForegroundTask(remainingTime.value);
      Workmanager().registerPeriodicTask(
        'timerTask',
        'timerTask',
        frequency: const Duration(seconds: 1),
        inputData: {
          'timerDuration': remainingTime.value.inSeconds,
        },
      );
      Get.bottomSheet(
        TimerBottomSheet(),
        backgroundColor: kprimaryBackgroundColor,
      );
      countdownTimer.value = Timer.periodic(
        const Duration(seconds: 1),
        (_) => setCountDown(),
      );
    }
  }

  void stopTimer() async {
    print('STOP TIMER EXECUTED-----------------------');
    countdownTimer.value?.cancel();
    isTimerPaused.value = false;
    isTimerRunning.value = false;
    initalTime.value = DateTime(0, 0, 0, 0, 1, 0);
    remainingTime.value = Duration(
      hours: initalTime.value.hour,
      minutes: initalTime.value.minute,
      seconds: initalTime.value.second,
    );
    currentTime.value = const Duration(hours: 0, minutes: 0, seconds: 0);
    startTime.value = 0;
    await _secureStorageProvider.removeRemainingTimeInSeconds();
    await _secureStorageProvider.removeStartTime();
    // Get.back();
  }

  void pauseTimer() async {
    countdownTimer.value?.cancel();
    isTimerPaused.value = true;
    await stopForegroundTask();
  }

  void resumeTimer() async {
    if (isTimerPaused.value) {
      countdownTimer.value = Timer.periodic(
        const Duration(seconds: 1),
        (_) => setCountDown(),
      );
      isTimerPaused.value = false;
      createForegroundTask();
      await startForegroundTask(remainingTime.value);
    }
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    final seconds = remainingTime.value.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      stopTimer();
    } else {
      remainingTime.value = Duration(seconds: seconds);
    }
  }

  void stopForegroundService() async {
    await stopForegroundTask();
  }
}
