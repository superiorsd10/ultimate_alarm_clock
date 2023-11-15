// import 'dart:async';
// import 'dart:isolate';

// import 'package:flutter/material.dart';
// import 'package:flutter_foreground_task/flutter_foreground_task.dart';

// class TimerHandlerModel extends TaskHandler {
//   Timer? _timer;
//   SendPort? _sendPort;
//   late ReceivePort _uiReceivePort;
//   late int timeRemaining;

//   @override
//   Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
//     _sendPort = sendPort;
//     _uiReceivePort = ReceivePort();

//     _sendPort?.send(_uiReceivePort.sendPort);

//     _uiReceivePort.listen((message) {
//       if (message is int) {
//         timeRemaining = message;
//         debugPrint('Event says, Time Remaining: $timeRemaining');

//         _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//           if (timeRemaining > 0) {
//             timeRemaining--;
//             sendPort?.send(timeRemaining);
//           } else {
//             timer.cancel();
//             sendPort?.send('Timer Completed');
//           }
//         });
//       }
//     });
//   }

//   @override
//   Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
//     _timer?.cancel();
//     await FlutterForegroundTask.clearAllData();
//   }

//   @override
//   Future<void> onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
//     if (timeRemaining == 0) {
//       FlutterForegroundTask.launchApp('/timer-ring-view');
//       sendPort?.send('timerRing');
//     } else if (timeRemaining > 0) {
//       Duration duration = Duration(seconds: timeRemaining);

//       int hours = duration.inHours;
//       int minutes = duration.inMinutes.remainder(60);
//       int seconds = duration.inSeconds.remainder(60);

//       print('$hours:${_twoDigits(minutes)}:${_twoDigits(seconds)}');

//       FlutterForegroundTask.updateService(
//         notificationTitle: 'Time Remaining',
//         notificationText:
//             '$hours:${_twoDigits(minutes)}:${_twoDigits(seconds)}',
//       );
//     }
//   }

//   @override
//   void onNotificationPressed() {
//     FlutterForegroundTask.launchApp('/bottom-nav-bar');
//     _sendPort?.send('onNotificationPressed');
//   }

//   String _twoDigits(int n) {
//     if (n >= 10) {
//       return '$n';
//     } else {
//       return '0$n';
//     }
//   }
// }
