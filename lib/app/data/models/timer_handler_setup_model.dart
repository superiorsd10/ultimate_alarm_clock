// import 'dart:async';
// import 'dart:isolate';

// import 'package:flutter/material.dart';
// import 'package:flutter_foreground_task/flutter_foreground_task.dart';
// import 'package:get/get.dart';
// import 'package:ultimate_alarm_clock/app/data/models/timer_handler_model.dart';
// import 'package:ultimate_alarm_clock/app/modules/timer/controllers/timer_controller.dart';

// @pragma('vm:entry-point')
// void startCallback() {
//   FlutterForegroundTask.setTaskHandler(TimerHandlerModel());
// }

// class TimerHandlerSetupModel {
//   late SendPort _sendPort;
//   ReceivePort? _receivePort;

//   restartForegroundTask(Duration timerDuration) async {
//     await stopForegroundTask();
//     createForegroundTask();
//     await startForegroundTask(timerDuration);
//   }

//   void createForegroundTask() {
//     FlutterForegroundTask.init(
//       androidNotificationOptions: AndroidNotificationOptions(
//         channelId: 'ulti_clock',
//         channelName: 'Ultimate Alarm Clock',
//         channelDescription: 'Ultimate Alarm Clock Channel',
//         channelImportance: NotificationChannelImportance.HIGH,
//         priority: NotificationPriority.HIGH,
//         iconData: const NotificationIconData(
//           resType: ResourceType.mipmap,
//           resPrefix: ResourcePrefix.ic,
//           name: 'launcher_foreground',
//         ),
//         buttons: [],
//       ),
//       iosNotificationOptions: const IOSNotificationOptions(
//         showNotification: true,
//         playSound: false,
//       ),
//       foregroundTaskOptions: const ForegroundTaskOptions(
//         interval: 1000,
//         isOnceEvent: false,
//         autoRunOnBoot: true,
//         allowWakeLock: true,
//         allowWifiLock: true,
//       ),
//     );
//   }

//   Future<bool> startForegroundTask(Duration timerDuration) async {
//     final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
//     final bool isRegistered = registerReceivePort(receivePort, timerDuration);
//     if (!isRegistered) {
//       debugPrint('Failed to register receivePort!');
//       return false;
//     }

//     return FlutterForegroundTask.startService(
//       notificationTitle: 'UltiClock is running!',
//       notificationText: 'Tap to return to the app',
//       callback: startCallback,
//     );
//   }

//   Future<bool> stopForegroundTask() {
//     return FlutterForegroundTask.stopService();
//   }

//   void _closeReceivePort() {
//     _receivePort?.close();
//     _receivePort = null;
//   }

//   bool registerReceivePort(
//     ReceivePort? newReceivePort,
//     Duration timerDuration,
//   ) {
//     if (newReceivePort == null) {
//       return false;
//     }

//     _closeReceivePort();

//     _receivePort = newReceivePort;
//     _receivePort?.listen((message) async {
//       if (message is SendPort) {
//         _sendPort = message;
//         // Send port has been initialized, let's send it the alarm details
//         _sendPort.send(timerDuration.inSeconds);
//       }
//       debugPrint('MAIN RECIEVED $message');

//       if (message is String) {
//         if (message == 'onNotificationPressed') {
//           if (Get.currentRoute != '/bottom-nav-bar') {
//             Get.offNamed('/bottom-nav-bar');
//           }
//         } else if (message == 'timerRing') {
//           FlutterForegroundTask.launchApp('/timer-ring-view');
//           if (Get.currentRoute != '/timer-ring-view') {
//             Get.offNamed('/timer-ring-view');
//           }
//         }
//       }
//     });

//     return _receivePort != null;
//   }
// }
