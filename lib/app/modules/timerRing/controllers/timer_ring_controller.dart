import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';

class TimerControlController extends GetxController {
  // late StreamSubscription<FGBGType> _subscription;

  @override
  void onInit() {
    super.onInit();
    print('TIMER CONTROL CONTROLLER INITIATED');
    FlutterRingtonePlayer.playAlarm();

    // Preventing app from being minimized!
    // _subscription = FGBGEvents.stream.listen((event) {
    //   if (event == FGBGType.background) {
    //     FlutterForegroundTask.launchApp();
    //   }
    // });
  }

  @override
  void onClose() async {
    super.onClose();

    print('TIMER CONTROL CONTROLLER DESTROYED');

    await FlutterRingtonePlayer.stop();

    // _subscription.cancel();
  }

  void stopForegroundService() async {
    // await stopForegroundTask();
  }
}
