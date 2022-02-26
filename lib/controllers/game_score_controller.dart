import 'package:get/get.dart';

class GameScoreController extends GetxController {
  int score = 0;
  void incrementScore() {
    score++;
    update();
  }

  void cleanScore() {
    score = 0;
    update();
  }

  static GameScoreController get to => Get.find<GameScoreController>();
}
