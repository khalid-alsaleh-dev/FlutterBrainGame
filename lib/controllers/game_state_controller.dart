import 'package:get/get.dart';
import 'package:brain_game/enums/game_state.dart';

class GameStateController extends GetxController {
  GameState state = GameState.start;
  static GameStateController get to => Get.find<GameStateController>();
  updateState(GameState newState) {
    state = newState;
    update();
  }
}
