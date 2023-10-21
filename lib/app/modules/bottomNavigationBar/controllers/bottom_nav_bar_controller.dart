import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  final activeTabIndex = 0.obs; 

  void changeTabIndex(int index) {
    activeTabIndex.value = index;
  }
}