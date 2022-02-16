import 'package:get/get.dart';

class GameVariableController extends GetxController {
  int score = 0;
  void incrementScore() {
    score++;
    update();
  }

  void cleanScore() {
    score = 0;
    update();
  }

  static GameVariableController get to => Get.find<GameVariableController>();
}
