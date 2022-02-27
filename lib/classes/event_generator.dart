import 'dart:math';
import 'package:brain_game/enums/event.dart';

class EventGenerator {
  /// A function generates a random event
  static Event generate() {
    int randomValue = Random(DateTime.now().millisecondsSinceEpoch).nextInt(105);
    if (randomValue <= 35) {
      return Event.firstAndSecond;
    } else if (35 < randomValue && randomValue <= 70) {
      return Event.secondAndThird;
    } else {
      return Event.firstAndThird;
    }
  }
}
