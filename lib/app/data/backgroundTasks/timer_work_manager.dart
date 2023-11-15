// import 'package:flutter_foreground_task/flutter_foreground_task.dart';
// import 'package:get/get.dart';
// import 'package:workmanager/workmanager.dart';

// void callbackDispatcher() {
//   Workmanager().executeTask((taskName, inputData) {
//     if (taskName == 'timerTask') {
//       int timerDurationInSeconds =
//           inputData!['timerDuration'];

//       if (timerDurationInSeconds > 0) {
//         timerDurationInSeconds -= 1;
//         print('TIMER WORK MANAGER: $timerDurationInSeconds');
//       } else {
//         print('TIMER WORK MANAGER: STOP THE TIMER');
//         FlutterForegroundTask.launchApp('/timer-ring-view');
//         if (Get.currentRoute != '/timer-ring-view') {
//           Get.offNamed('/timer-ring-view');
//         }
//       }
//     }
//     return Future.value(true); 
//   });
// }
