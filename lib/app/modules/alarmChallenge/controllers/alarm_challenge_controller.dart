import 'dart:async';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shake/shake.dart';
import 'package:ultimate_alarm_clock/app/data/models/alarm_model.dart';
import 'package:ultimate_alarm_clock/app/utils/constants.dart';

class AlarmChallengeController extends GetxController {
  AlarmModel alarmRecord = Get.arguments;
  final RxDouble progress = 1.0.obs;

  final RxInt shakedCount = 0.obs;
  final isShakeOngoing = Status.initialized.obs;
  ShakeDetector? _shakeDetector;
  MobileScannerController? qrController;

  final qrValue = "".obs;
  final isQrOngoing = Status.initialized.obs;

  restartQRCodeController() {
    qrController = MobileScannerController(
      autoStart: true,
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void onInit() {
    super.onInit();
    _startTimer();

    isShakeOngoing.listen((value) {
      if (value == Status.ongoing) {
        _shakeDetector = ShakeDetector.autoStart(onPhoneShake: () {
          shakedCount.value -= 1;
          restartTimer();
        });
      }
    });

    shakedCount.listen((value) {
      if (value == 0) {
        isShakeOngoing.value = Status.completed;
        Get.back();
        _shakeDetector!.stopListening();
      }
    });

    if (alarmRecord.isQrEnabled) {
      qrController = MobileScannerController(
        autoStart: true,
        detectionSpeed: DetectionSpeed.noDuplicates,
        facing: CameraFacing.back,
        torchEnabled: false,
      );
    }

    qrValue.listen((value) {
      restartTimer();
      if (value == alarmRecord.qrValue) {
        isQrOngoing.value = Status.completed;
        qrController!.dispose();
        Get.back();
      }
    });
  }

  void _startTimer() async {
    final duration = Duration(seconds: 15);
    final totalIterations = 1500000;
    final decrement = 0.000001;

    for (var i = totalIterations; i > 0; i--) {
      if (progress.value <= 0.0) {
        // Get.offAllNamed('/alarm-ring');
        break;
      }
      await Future.delayed(duration ~/ i);
      progress.value -= decrement;
    }
  }

  restartTimer() {
    progress.value = 1.0; // Reset the progress to its initial value
    _startTimer(); // Start the timer again
  }
}
